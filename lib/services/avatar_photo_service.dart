import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/user_prefs.dart';

enum _GalleryChoice { always, once, deny }

/// Загрузка личного фото аватара из галереи.
class AvatarPhotoService {
  AvatarPhotoService._();
  static final AvatarPhotoService instance = AvatarPhotoService._();

  final _picker = ImagePicker();

  Future<_GalleryChoice?> _askGalleryPermission(BuildContext context) async {
    return showDialog<_GalleryChoice>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Доступ к фото',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: const Text(
          'SYNAPSE хочет открыть галерею, чтобы выбрать аватар. '
          'В следующем системном окне можно разрешить полностью, '
          'только сейчас или запретить.',
          style: TextStyle(color: AppColors.textSecondary, height: 1.45),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, _GalleryChoice.deny),
            child: const Text('Запретить'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, _GalleryChoice.once),
            child: const Text('Только сейчас'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.tiffany),
            onPressed: () => Navigator.pop(ctx, _GalleryChoice.always),
            child: const Text('Разрешить полностью'),
          ),
        ],
      ),
    );
  }

  Future<bool> _requestSystemPermission() async {
    if (!Platform.isAndroid && !Platform.isIOS) return true;

    var status = await Permission.photos.status;
    if (status.isGranted || status.isLimited) return true;

    status = await Permission.photos.request();
    if (status.isGranted || status.isLimited) return true;

    if (Platform.isAndroid) {
      final storage = await Permission.storage.request();
      if (storage.isGranted) return true;
    }

    return false;
  }

  Future<String?> pickAndSave(BuildContext context) async {
    final choice = await _askGalleryPermission(context);
    if (choice == null || choice == _GalleryChoice.deny) return null;
    if (!context.mounted) return null;

    if (choice != _GalleryChoice.once) {
      final ok = await _requestSystemPermission();
      if (!ok && choice == _GalleryChoice.always) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Нет доступа к галерее. Проверьте разрешения.'),
            ),
          );
        }
        return null;
      }
    }

    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );
    if (file == null) return null;

    final uid = Supabase.instance.client.auth.currentUser?.id ?? 'anon';
    final dir = await getApplicationDocumentsDirectory();
    final dest = File('${dir.path}/avatar_$uid.jpg');
    await File(file.path).copy(dest.path);
    await UserPrefs.setAvatarPhotoPath(dest.path);
    await UserPrefs.setUsePhotoAvatar(true);
    return dest.path;
  }

  Future<void> removePhoto() async {
    final path = await UserPrefs.getAvatarPhotoPath();
    if (path != null) {
      try {
        final f = File(path);
        if (await f.exists()) await f.delete();
      } catch (_) {}
    }
    await UserPrefs.clearAvatarPhoto();
  }
}

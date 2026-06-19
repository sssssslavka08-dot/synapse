import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/user_prefs.dart';

/// Аватар: фото из галереи или эмодзи-стикер.
class AvatarDisplay extends StatelessWidget {
  final String emoji;
  final double fontSize;
  final Color? backgroundColor;

  const AvatarDisplay({
    super.key,
    required this.emoji,
    this.fontSize = 40,
    this.backgroundColor,
  });

  static Future<Widget> buildContent({
    required String emoji,
    double fontSize = 40,
  }) async {
    final usePhoto = await UserPrefs.getUsePhotoAvatar();
    final path = await UserPrefs.getAvatarPhotoPath();
    if (usePhoto && path != null) {
      final file = File(path);
      if (await file.exists()) {
        return Image.file(file, fit: BoxFit.cover);
      }
    }
    return Center(
      child: Text(emoji, style: TextStyle(fontSize: fontSize)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: buildContent(emoji: emoji, fontSize: fontSize),
      builder: (_, snap) {
        final child = snap.data ??
            Center(child: Text(emoji, style: TextStyle(fontSize: fontSize)));
        return Container(
          color: backgroundColor ?? AppColors.darkCard,
          child: child,
        );
      },
    );
  }
}

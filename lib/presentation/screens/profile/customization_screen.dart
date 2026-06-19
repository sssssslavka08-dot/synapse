import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/user_prefs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/avatar_photo_service.dart';
import '../../../services/shop_service.dart';
import '../../../services/user_store.dart';
import '../../widgets/avatar_display.dart';

// ═══════════════════════════════════════════════════════════════
//  CustomizationScreen — смена аватарки, рамки, цвета ника
// ═══════════════════════════════════════════════════════════════
class CustomizationScreen extends StatefulWidget {
  final String name;
  const CustomizationScreen({super.key, required this.name});

  @override
  State<CustomizationScreen> createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  List<String> _ownedIds = [];
  Map<String, String> _equipped = {};
  String _avatarEmoji = '😀';
  bool _usePhotoAvatar = false;
  bool _loading = true;
  Set<String> _ownedPremiumAvatars = {};
  static const _freeAvatarCount = 8;
  static const _avatarPrice = 200;

  static const _avatarOptions = [
    '😀', '😎', '🤓', '🧑‍💻', '👨‍🎓', '👩‍🎓', '🦊', '🐱', '🐶', '🐼',
    '🦁', '🐸', '🦄', '🐲', '🦅', '🐬', '🌟', '🔥', '💎', '🎮',
    '🎧', '🎯', '🏆', '⚡', '🚀', '🌈', '🎭', '🤖', '👾', '🎪',
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
    _load();
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);

    try {
      final owned = await ShopService.instance.getInventoryIds();
      final equipped = await ShopService.instance.getEquipped();
      final avatar = await UserPrefs.getAvatarEmoji();
      final usePhoto = await UserPrefs.getUsePhotoAvatar();
      final premium = await UserPrefs.getOwnedPremiumAvatars();
      if (mounted) {
        setState(() {
          _ownedIds = owned;
          _equipped = equipped;
          _avatarEmoji = avatar;
          _usePhotoAvatar = usePhoto;
          _ownedPremiumAvatars = premium;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _pickPhotoFromGallery() async {
    final path = await AvatarPhotoService.instance.pickAndSave(context);
    if (!mounted) return;
    if (path != null) {
      setState(() => _usePhotoAvatar = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Фото аватара обновлено'),
          backgroundColor: AppColors.tiffany,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  Future<void> _removePhoto() async {
    await AvatarPhotoService.instance.removePhoto();
    if (mounted) setState(() => _usePhotoAvatar = false);
  }

  Future<void> _selectAvatar(String emoji, int index) async {
    if (index >= _freeAvatarCount && !_ownedPremiumAvatars.contains(emoji)) {
      await UserStore.instance.refresh();
      if (UserStore.instance.coins < _avatarPrice) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Нужно 200 монет. Заработай в уроках!'),
            ),
          );
        }
        return;
      }
      final uid = Supabase.instance.client.auth.currentUser?.id;
      if (uid != null) {
        final newCoins = UserStore.instance.coins - _avatarPrice;
        await Supabase.instance.client
            .from('users')
            .update({'coins': newCoins})
            .eq('id', uid);
        UserStore.instance.applyDelta(coinsDelta: -_avatarPrice);
      }
      await UserPrefs.addOwnedPremiumAvatar(emoji);
      _ownedPremiumAvatars.add(emoji);
    }
    await UserPrefs.setUsePhotoAvatar(false);
    setState(() {
      _avatarEmoji = emoji;
      _usePhotoAvatar = false;
    });
    await UserPrefs.setAvatarEmoji(emoji);

    // Sync to Supabase (fire-and-forget)
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      if (uid != null) {
        Supabase.instance.client.from('users').update({
          'avatar_emoji': emoji,
        }).eq('id', uid).then((_) {}, onError: (_) {});
      }
    } catch (_) {}
  }

  Future<void> _equipItem(ShopItem item) async {
    await ShopService.instance.equip(item);
    await _load();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('💎 "${item.name}" экипировано!'),
          backgroundColor: AppColors.tiffany,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  Future<void> _unequipCategory(ShopCategory cat) async {
    await ShopService.instance.unequip(cat);
    await _load();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Предмет снят'),
          backgroundColor: const Color(0xFF64748B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildPreview(),
            _buildTabs(),
            if (_loading)
              const Expanded(
                child: Center(child: CircularProgressIndicator(color: AppColors.tiffany)),
              )
            else
              Expanded(
                child: TabBarView(
                  controller: _tabCtrl,
                  children: [
                    _buildAvatarGrid(),
                    _buildFramesList(),
                    _buildPrefixesList(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: const BoxDecoration(
        color: AppColors.darkCard,
        border: Border(bottom: BorderSide(color: AppColors.darkBorder)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: AppColors.darkBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.darkBorder),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Color(0xFF4D6766)),
            ),
          ),
          const SizedBox(width: 12),
          const Text('Кастомизация', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary,
          )),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    final equippedFrameId = _equipped['avatarFrame'];
    final equippedPrefixId = _equipped['nickPrefix'];

    ShopItem? frameItem;
    ShopItem? prefixItem;
    if (equippedFrameId != null) {
      try {
        frameItem = ShopCatalog.all.firstWhere((i) => i.id == equippedFrameId);
      } catch (_) {}
    }
    if (equippedPrefixId != null) {
      try {
        prefixItem = ShopCatalog.all.firstWhere((i) => i.id == equippedPrefixId);
      } catch (_) {}
    }

    final borderColor = frameItem != null
        ? Color(frameItem.meta['border_color'] as int? ?? 0xFF0ABDB9)
        : const Color(0xFF3FCFCC);
    final borderWidth = (frameItem?.meta['border_width'] as num?)?.toDouble() ?? 3.0;
    final prefixColor = prefixItem != null
        ? Color(prefixItem.meta['color'] as int? ?? 0xFFFFFFFF)
        : null;
    final prefixText = prefixItem?.meta['prefix_text'] as String?;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Аватар с рамкой
          Container(
            width: 96, height: 96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: borderColor, width: borderWidth),
              boxShadow: frameItem?.meta['glow'] != null
                  ? [BoxShadow(
                      color: Color(frameItem!.meta['glow'] as int).withValues(alpha: 0.4),
                      blurRadius: 20,
                    )]
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: AvatarDisplay(
                emoji: _avatarEmoji,
                fontSize: 48,
                backgroundColor: AppColors.darkCard,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Ник с префиксом
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixText != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: (prefixColor ?? AppColors.tiffany).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(prefixText, style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w800,
                    color: prefixColor ?? AppColors.tiffany,
                  )),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w800,
                  color: prefixColor ?? AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: TabBar(
        controller: _tabCtrl,
        labelColor: AppColors.tiffany,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: AppColors.tiffany,
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        tabs: const [
          Tab(icon: Icon(Icons.face_rounded, size: 18), text: 'Аватар'),
          Tab(icon: Icon(Icons.crop_square_rounded, size: 18), text: 'Рамки'),
          Tab(icon: Icon(Icons.auto_awesome_rounded, size: 18), text: 'Префиксы'),
        ],
      ),
    );
  }

  // ── Аватар ────────────────────────────────────────────────────

  Widget _buildAvatarGrid() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildPhotoPickerCard(),
        const SizedBox(height: 16),
        const Text(
          'Стикеры',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemCount: _avatarOptions.length,
          itemBuilder: (_, i) {
        final emoji = _avatarOptions[i];
        final selected = emoji == _avatarEmoji;
        final isFree = i < _freeAvatarCount;
        final owned = isFree || _ownedPremiumAvatars.contains(emoji);
        return GestureDetector(
          onTap: () => _selectAvatar(emoji, i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: selected ? AppColors.tiffany.withValues(alpha: 0.15) : AppColors.darkCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected ? AppColors.tiffany : AppColors.darkBorder,
                width: selected ? 2.5 : 1.5,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(emoji, style: TextStyle(fontSize: 28, color: owned ? null : Colors.white24)),
                if (!owned)
                  const Positioned(
                    bottom: 2,
                    child: Icon(Icons.lock_rounded, size: 12, color: AppColors.tiffany),
                  ),
                if (!owned)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Text(
                      '$_avatarPrice',
                      style: const TextStyle(fontSize: 8, color: AppColors.tiffany, fontWeight: FontWeight.w800),
                    ),
                  ),
              ],
            ),
          ),
        );
          },
        ),
      ],
    );
  }

  Widget _buildPhotoPickerCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Своё фото',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Загрузите фото из галереи — появится системный запрос разрешений.',
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.tiffany,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: _pickPhotoFromGallery,
                  icon: const Icon(Icons.photo_library_rounded, size: 20),
                  label: const Text('Выбрать из галереи'),
                ),
              ),
              if (_usePhotoAvatar) ...[
                const SizedBox(width: 10),
                IconButton(
                  tooltip: 'Убрать фото',
                  onPressed: _removePhoto,
                  icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444)),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // ── Рамки ─────────────────────────────────────────────────────

  Widget _buildFramesList() {
    final frames = ShopCatalog.byCategory(ShopCategory.avatarFrame);
    final equippedId = _equipped['avatarFrame'];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: frames.length,
      itemBuilder: (_, i) {
        final item = frames[i];
        final owned = _ownedIds.contains(item.id);
        final equipped = equippedId == item.id;
        final borderColor = Color(item.meta['border_color'] as int? ?? 0xFF0ABDB9);

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: equipped ? borderColor.withValues(alpha: 0.08) : AppColors.darkCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: equipped ? borderColor : AppColors.darkBorder,
              width: equipped ? 2 : 1.5,
            ),
          ),
          child: Row(
            children: [
              // Превью рамки
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: borderColor,
                    width: (item.meta['border_width'] as num?)?.toDouble() ?? 3.0,
                  ),
                ),
                child: Center(child: Text(_avatarEmoji, style: const TextStyle(fontSize: 24))),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary,
                    )),
                    Text(
                      owned ? (equipped ? 'Экипировано' : 'В инвентаре') : '${item.price} 🪙',
                      style: TextStyle(
                        fontSize: 12,
                        color: equipped ? borderColor : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (owned)
                equipped
                    ? _ActionButton(
                        label: 'Снять',
                        color: const Color(0xFF64748B),
                        onTap: () => _unequipCategory(ShopCategory.avatarFrame),
                      )
                    : _ActionButton(
                        label: 'Надеть',
                        color: borderColor,
                        onTap: () => _equipItem(item),
                      )
              else
                _ActionButton(
                  label: '🔒',
                  color: const Color(0xFF64748B),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Сначала купи в магазине'),
                        backgroundColor: const Color(0xFF64748B),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  // ── Префиксы ──────────────────────────────────────────────────

  Widget _buildPrefixesList() {
    final prefixes = ShopCatalog.byCategory(ShopCategory.nickPrefix);
    final equippedId = _equipped['nickPrefix'];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: prefixes.length,
      itemBuilder: (_, i) {
        final item = prefixes[i];
        final owned = _ownedIds.contains(item.id);
        final equipped = equippedId == item.id;
        final color = Color(item.meta['color'] as int? ?? 0xFFFFFFFF);
        final prefixText = item.meta['prefix_text'] as String?;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: equipped ? color.withValues(alpha: 0.08) : AppColors.darkCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: equipped ? color : AppColors.darkBorder,
              width: equipped ? 2 : 1.5,
            ),
          ),
          child: Row(
            children: [
              // Превью цвета
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: color.withValues(alpha: 0.4)),
                ),
                child: Center(
                  child: prefixText != null
                      ? Text(prefixText, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: color))
                      : Container(width: 24, height: 24, decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 8)],
                        )),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700, color: color,
                    )),
                    Text(
                      owned ? (equipped ? 'Экипировано' : 'В инвентаре') : '${item.price} 🪙',
                      style: TextStyle(
                        fontSize: 12,
                        color: equipped ? color : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (owned)
                equipped
                    ? _ActionButton(
                        label: 'Снять',
                        color: const Color(0xFF64748B),
                        onTap: () => _unequipCategory(ShopCategory.nickPrefix),
                      )
                    : _ActionButton(
                        label: 'Надеть',
                        color: color,
                        onTap: () => _equipItem(item),
                      )
              else
                _ActionButton(
                  label: '🔒',
                  color: const Color(0xFF64748B),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Сначала купи в магазине'),
                        backgroundColor: const Color(0xFF64748B),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Text(label, style: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w700, color: color,
        )),
      ),
    );
  }
}

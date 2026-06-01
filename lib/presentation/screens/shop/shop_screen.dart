import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../services/shop_service.dart';
import '../../../services/user_store.dart';

class ShopScreen extends StatefulWidget {
  final bool isKidsMode;
  const ShopScreen({super.key, this.isKidsMode = false});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  int _coins = 0;
  List<String> _ownedIds = [];
  Map<String, String> _equipped = {};
  bool _loading = true;

  final _categories = [
    (label: '✨ Префиксы', cat: ShopCategory.nickPrefix),
    (label: '🖼️ Рамки', cat: ShopCategory.avatarFrame),
    (label: '🎁 Стикеры', cat: ShopCategory.stickerPack),
    (label: '👕 Мерч', cat: ShopCategory.merchandise),
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: _categories.length, vsync: this);
    _loadData();
    UserStore.instance.addListener(_onWallet);
  }

  void _onWallet() {
    if (!mounted) return;
    setState(() => _coins = UserStore.instance.coins);
  }

  @override
  void dispose() {
    UserStore.instance.removeListener(_onWallet);
    _tabCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);

    if (!UserStore.instance.loaded) {
      await UserStore.instance.refresh();
    }
    if (mounted) setState(() => _coins = UserStore.instance.coins);

    // Загружаем инвентарь (может не существовать таблица)
    try {
      final owned = await ShopService.instance.getInventoryIds();
      final equipped = await ShopService.instance.getEquipped();
      if (mounted) {
        setState(() {
          _ownedIds = owned;
          _equipped = equipped;
        });
      }
    } catch (_) {}

    if (mounted) setState(() => _loading = false);
  }

  Future<void> _buy(ShopItem item) async {
    final result = await ShopService.instance.purchase(item);

    if (!mounted) return;

    String msg;
    bool success = false;
    switch (result) {
      case ShopPurchaseResult.success:
        msg = '✅ Куплено! "${item.name}" добавлено в инвентарь';
        success = true;
        break;
      case ShopPurchaseResult.notEnoughCoins:
        msg = '❌ Недостаточно монет! Нужно ${item.price} 🪙';
        break;
      case ShopPurchaseResult.alreadyOwned:
        msg = 'ℹ️ У тебя уже есть этот предмет';
        break;
      case ShopPurchaseResult.notLoggedIn:
        msg = '🔐 Войди в аккаунт, чтобы покупать предметы';
        break;
      default:
        msg = '⚠️ Ошибка покупки';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor:
            success ? AppColors.tiffany : const Color(0xFF64748B),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );

    if (success) _loadData();
  }

  Future<void> _equip(ShopItem item) async {
    await ShopService.instance.equip(item);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('💎 "${item.name}" экипировано!'),
          backgroundColor: AppColors.tiffany,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 2),
        ),
      );
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKids = widget.isKidsMode;
    final bgColor =
        isKids ? const Color(0xFFFFF9F0) : AppColors.darkBg;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Шапка
            _buildHeader(isKids),

            // Табы категорий
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.darkBorder),
              ),
              child: TabBar(
                controller: _tabCtrl,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicator: BoxDecoration(
                  color: isKids
                      ? const Color(0xFFFF6B35)
                      : AppColors.tiffany,
                  borderRadius: BorderRadius.circular(12),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                padding: const EdgeInsets.all(4),
                tabs: _categories
                    .map((c) => Tab(text: c.label))
                    .toList(),
              ),
            ),

            // Контент
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.tiffany))
                  : TabBarView(
                      controller: _tabCtrl,
                      children: _categories
                          .map((c) => _CategoryGrid(
                                items: ShopCatalog.byCategory(c.cat),
                                ownedIds: _ownedIds,
                                equipped: _equipped,
                                coins: _coins,
                                isKidsMode: isKids,
                                onBuy: _buy,
                                onEquip: _equip,
                              ))
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isKids) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          if (Navigator.of(context).canPop()) ...[
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.darkBorder),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: 18, color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isKids ? '🛍️ Магазинчик' : '🛒 Магазин',
                style: TextStyle(
                  fontSize: isKids ? 22 : 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const Text(
                'Трать монеты на крутые штуки!',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ],
          ),
          const Spacer(),
          // Кошелёк
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFD700), Color(0xFFFF9800)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🪙', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Text(
                  _coins.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Сетка товаров категории ──────────────────────────────────────
class _CategoryGrid extends StatelessWidget {
  final List<ShopItem> items;
  final List<String> ownedIds;
  final Map<String, String> equipped;
  final int coins;
  final bool isKidsMode;
  final Future<void> Function(ShopItem) onBuy;
  final Future<void> Function(ShopItem) onEquip;

  const _CategoryGrid({
    required this.items,
    required this.ownedIds,
    required this.equipped,
    required this.coins,
    required this.isKidsMode,
    required this.onBuy,
    required this.onEquip,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];
        final owned = ownedIds.contains(item.id);
        final isEquipped =
            equipped[item.category.name] == item.id;
        return _ShopCard(
          item: item,
          owned: owned,
          isEquipped: isEquipped,
          canAfford: coins >= item.price,
          isKidsMode: isKidsMode,
          onBuy: () => onBuy(item),
          onEquip: () => onEquip(item),
        );
      },
    );
  }
}

// ── Карточка товара ──────────────────────────────────────────────
class _ShopCard extends StatelessWidget {
  final ShopItem item;
  final bool owned;
  final bool isEquipped;
  final bool canAfford;
  final bool isKidsMode;
  final VoidCallback onBuy;
  final VoidCallback onEquip;

  const _ShopCard({
    required this.item,
    required this.owned,
    required this.isEquipped,
    required this.canAfford,
    required this.isKidsMode,
    required this.onBuy,
    required this.onEquip,
  });

  Color get _rarityColor => Color(item.rarity.colorValue);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isEquipped
              ? _rarityColor
              : _rarityColor.withValues(alpha: 0.3),
          width: isEquipped ? 2.5 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: _rarityColor.withValues(alpha: isEquipped ? 0.2 : 0.08),
            blurRadius: isEquipped ? 12 : 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          // Превью товара
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                // Фон с редкостью
                Container(
                  decoration: BoxDecoration(
                    color: _rarityColor.withValues(alpha: 0.08),
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18)),
                  ),
                  child: Center(child: _buildPreview()),
                ),
                // Бейдж редкости
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _rarityColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.rarity.label,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                // Метка "Экипировано"
                if (isEquipped)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: _rarityColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_rounded,
                          size: 12, color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),

          // Инфо и кнопка
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.description,
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  // Кнопка купить/экипировать
                  _buildButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreview() {
    if (item.imagePlaceholder != null) {
      return Text(item.imagePlaceholder!,
          style: const TextStyle(fontSize: 44));
    }

    switch (item.category) {
      case ShopCategory.nickPrefix:
        final color = Color((item.meta['color'] ?? 0xFF0ABDB9) as int);
        return Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.6),
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text(
            'SYNAPSE',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: color,
              shadows: [
                Shadow(
                  color: color.withValues(alpha: 0.9),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        );

      case ShopCategory.avatarFrame:
        final borderColor =
            Color((item.meta['border_color'] ?? 0xFF0ABDB9) as int);
        final glow =
            item.meta.containsKey('glow')
                ? Color((item.meta['glow'] as int))
                : borderColor;
        return Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.tiffany.withValues(alpha: 0.15),
            border: Border.all(
              color: borderColor,
              width: (item.meta['border_width'] ?? 3.0) as double,
            ),
            boxShadow: [
              BoxShadow(
                color: glow.withValues(alpha: 0.5),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ],
          ),
          child: const Center(
            child: Text('👤', style: TextStyle(fontSize: 24)),
          ),
        );

      default:
        return const Text('🎁', style: TextStyle(fontSize: 40));
    }
  }

  Widget _buildButton() {
    if (owned) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isEquipped ? null : onEquip,
          style: ElevatedButton.styleFrom(
            backgroundColor: isEquipped
                ? const Color(0xFF4CAF50)
                : _rarityColor,
            foregroundColor: Colors.white,
            elevation: 0,
            padding:
                const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            isEquipped ? '✓ Экипировано' : 'Надеть',
            style: const TextStyle(
                fontSize: 11, fontWeight: FontWeight.w700),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canAfford ? onBuy : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canAfford
              ? _rarityColor
              : AppColors.darkBorder,
          foregroundColor:
              canAfford ? Colors.white : AppColors.textMuted,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🪙', style: TextStyle(fontSize: 11)),
            const SizedBox(width: 3),
            Text(
              item.price.toString(),
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

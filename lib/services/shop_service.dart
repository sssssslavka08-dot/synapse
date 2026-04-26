import 'package:supabase_flutter/supabase_flutter.dart';

final _db = Supabase.instance.client;

// ── Модель товара в магазине ─────────────────────────────────────
class ShopItem {
  final String id;
  final ShopCategory category;
  final String name;
  final String description;
  final int price;
  final Rarity rarity;
  final String? imagePlaceholder;
  final Map<String, dynamic> meta;

  const ShopItem({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    required this.rarity,
    this.imagePlaceholder,
    this.meta = const {},
  });
}

enum ShopCategory {
  nickPrefix,
  avatarFrame,
  stickerPack,
  merchandise,
}

enum Rarity {
  common,
  uncommon,
  rare,
  epic,
  legendary,
}

extension RarityExt on Rarity {
  String get label {
    switch (this) {
      case Rarity.common:    return 'Обычная';
      case Rarity.uncommon:  return 'Необычная';
      case Rarity.rare:      return 'Редкая';
      case Rarity.epic:      return 'Эпическая';
      case Rarity.legendary: return 'Легендарная';
    }
  }

  int get colorValue {
    switch (this) {
      case Rarity.common:    return 0xFF8EAEAC;
      case Rarity.uncommon:  return 0xFF4CAF50;
      case Rarity.rare:      return 0xFF2196F3;
      case Rarity.epic:      return 0xFF9C27B0;
      case Rarity.legendary: return 0xFFFF9800;
    }
  }
}

// ── Каталог товаров ──────────────────────────────────────────────
class ShopCatalog {
  static const List<ShopItem> all = [
    // ─── ПРЕФИКСЫ НИКНЕЙМА (неон) ────────────────────────────────
    ShopItem(
      id: 'prefix_neon_cyan',
      category: ShopCategory.nickPrefix,
      name: 'Неон Циан',
      description: 'Яркий циановый неон-префикс для ника',
      price: 100,
      rarity: Rarity.common,
      meta: {'color': 0xFF00E5FF, 'glow': 0xFF00E5FF},
    ),
    ShopItem(
      id: 'prefix_neon_green',
      category: ShopCategory.nickPrefix,
      name: 'Неон Зелёный',
      description: 'Сочный зелёный неон-префикс для ника',
      price: 100,
      rarity: Rarity.common,
      meta: {'color': 0xFF00E676, 'glow': 0xFF00E676},
    ),
    ShopItem(
      id: 'prefix_neon_pink',
      category: ShopCategory.nickPrefix,
      name: 'Неон Розовый',
      description: 'Яркий розовый неон-префикс для ника',
      price: 100,
      rarity: Rarity.common,
      meta: {'color': 0xFFFF4081, 'glow': 0xFFFF4081},
    ),
    ShopItem(
      id: 'prefix_neon_orange',
      category: ShopCategory.nickPrefix,
      name: 'Неон Оранжевый',
      description: 'Горячий оранжевый неон-префикс для ника',
      price: 100,
      rarity: Rarity.common,
      meta: {'color': 0xFFFF6D00, 'glow': 0xFFFF6D00},
    ),
    ShopItem(
      id: 'prefix_neon_yellow',
      category: ShopCategory.nickPrefix,
      name: 'Неон Жёлтый',
      description: 'Солнечный жёлтый неон-префикс для ника',
      price: 100,
      rarity: Rarity.common,
      meta: {'color': 0xFFFFD600, 'glow': 0xFFFFD600},
    ),
    ShopItem(
      id: 'prefix_neon_purple',
      category: ShopCategory.nickPrefix,
      name: 'Неон Фиолетовый',
      description: 'Мистический фиолетовый неон — эксклюзив для Legend',
      price: 100,
      rarity: Rarity.legendary,
      meta: {'color': 0xFFE040FB, 'glow': 0xFFE040FB},
    ),

    // ─── РАМКИ ДЛЯ АВАТАРКИ ──────────────────────────────────────
    ShopItem(
      id: 'frame_basic_teal',
      category: ShopCategory.avatarFrame,
      name: 'Бирюзовая рамка',
      description: 'Стандартная бирюзовая рамка',
      price: 50,
      rarity: Rarity.common,
      meta: {'border_color': 0xFF0ABDB9, 'border_width': 3.0},
    ),
    ShopItem(
      id: 'frame_gold',
      category: ShopCategory.avatarFrame,
      name: 'Золотая рамка',
      description: 'Блестящая золотая рамка для победителей',
      price: 150,
      rarity: Rarity.uncommon,
      meta: {'border_color': 0xFFFFD700, 'border_width': 4.0},
    ),
    ShopItem(
      id: 'frame_fire',
      category: ShopCategory.avatarFrame,
      name: 'Огненная рамка',
      description: 'Горящая рамка с огненным эффектом',
      price: 250,
      rarity: Rarity.rare,
      meta: {'border_color': 0xFFFF6B35, 'border_width': 4.0, 'animated': true},
    ),
    ShopItem(
      id: 'frame_ice',
      category: ShopCategory.avatarFrame,
      name: 'Ледяная рамка',
      description: 'Кристально чистая ледяная рамка',
      price: 250,
      rarity: Rarity.rare,
      meta: {'border_color': 0xFF00E5FF, 'border_width': 4.0},
    ),
    ShopItem(
      id: 'frame_galaxy',
      category: ShopCategory.avatarFrame,
      name: 'Галактическая',
      description: 'Рамка с галактическим градиентом',
      price: 400,
      rarity: Rarity.epic,
      meta: {
        'gradient': [0xFF6A11CB, 0xFF2575FC],
        'border_width': 5.0,
      },
    ),
    ShopItem(
      id: 'frame_neon_purple',
      category: ShopCategory.avatarFrame,
      name: 'Неон Фиолетовый',
      description: 'Эксклюзивная рамка Legend с фиолетовым неон-свечением',
      price: 500,
      rarity: Rarity.legendary,
      meta: {'border_color': 0xFF9B59B6, 'glow': 0xFFE040FB, 'border_width': 5.0},
    ),
    ShopItem(
      id: 'frame_rainbow',
      category: ShopCategory.avatarFrame,
      name: 'Радужная рамка',
      description: 'Переливающаяся радужная рамка',
      price: 350,
      rarity: Rarity.epic,
      meta: {'rainbow': true, 'border_width': 5.0},
    ),
    ShopItem(
      id: 'frame_diamond',
      category: ShopCategory.avatarFrame,
      name: 'Алмазная рамка',
      description: 'Самая редкая рамка — сверкает как бриллиант',
      price: 500,
      rarity: Rarity.legendary,
      meta: {'border_color': 0xFFB9F2FF, 'glow': 0xFF00E5FF, 'border_width': 6.0},
    ),

    // ─── СТИКЕР-ПАК ──────────────────────────────────────────────
    ShopItem(
      id: 'sticker_pack_v1',
      category: ShopCategory.stickerPack,
      name: 'Стикер-пак v1',
      description: 'Набор стикеров с Нейрончиком. Фото добавится скоро!',
      price: 2000,
      rarity: Rarity.rare,
      imagePlaceholder: '🎁',
      meta: {'count': 12, 'coming_soon_photo': true},
    ),

    // ─── МЕРЧ ─────────────────────────────────────────────────────
    ShopItem(
      id: 'merch_mug_set',
      category: ShopCategory.merchandise,
      name: 'Кружка + блокнот + ручка',
      description: 'Стильный набор SYNAPSE для учёбы. Фото скоро!',
      price: 5000,
      rarity: Rarity.epic,
      imagePlaceholder: '☕📔✏️',
      meta: {'physical': true, 'coming_soon_photo': true},
    ),
    ShopItem(
      id: 'merch_clothes',
      category: ShopCategory.merchandise,
      name: 'Мерч: кофта + майка + штаны',
      description: 'Эксклюзивный комплект одежды SYNAPSE. Фото скоро!',
      price: 10000,
      rarity: Rarity.legendary,
      imagePlaceholder: '👕👖',
      meta: {'physical': true, 'coming_soon_photo': true},
    ),
  ];

  static List<ShopItem> byCategory(ShopCategory cat) =>
      all.where((i) => i.category == cat).toList();
}

// ── Сервис магазина ──────────────────────────────────────────────
class ShopService {
  ShopService._();
  static final instance = ShopService._();

  String? get _uid => _db.auth.currentUser?.id;

  // Купить товар
  Future<ShopPurchaseResult> purchase(ShopItem item) async {
    if (_uid == null) return ShopPurchaseResult.notLoggedIn;

    final profile = await _db
        .from('users')
        .select('coins, subscription_type')
        .eq('id', _uid!)
        .maybeSingle();

    if (profile == null) return ShopPurchaseResult.error;

    final coins = (profile['coins'] ?? 0) as int;
    if (coins < item.price) return ShopPurchaseResult.notEnoughCoins;

    // Проверяем не куплено ли уже
    final existing = await _db
        .from('user_inventory')
        .select('id')
        .eq('user_id', _uid!)
        .eq('item_id', item.id)
        .maybeSingle();

    if (existing != null) return ShopPurchaseResult.alreadyOwned;

    // Списываем монеты
    await _db.from('users').update({
      'coins': coins - item.price,
    }).eq('id', _uid!);

    // Добавляем в инвентарь
    await _db.from('user_inventory').insert({
      'user_id': _uid,
      'item_id': item.id,
      'item_type': item.category.name,
      'purchased_at': DateTime.now().toIso8601String(),
      'is_equipped': false,
    });

    return ShopPurchaseResult.success;
  }

  // Экипировать предмет
  Future<void> equip(ShopItem item) async {
    if (_uid == null) return;

    // Снять предыдущее в этой категории
    await _db
        .from('user_inventory')
        .update({'is_equipped': false})
        .eq('user_id', _uid!)
        .eq('item_type', item.category.name);

    // Надеть новое
    await _db
        .from('user_inventory')
        .update({'is_equipped': true})
        .eq('user_id', _uid!)
        .eq('item_id', item.id);

    // Обновить профиль
    if (item.category == ShopCategory.avatarFrame) {
      await _db.from('users').update({
        'equipped_frame': item.id,
      }).eq('id', _uid!);
    } else if (item.category == ShopCategory.nickPrefix) {
      await _db.from('users').update({
        'equipped_prefix': item.id,
        'nick_prefix_color': item.meta['color']?.toString(),
      }).eq('id', _uid!);
    }
  }

  // Получить инвентарь пользователя
  Future<List<String>> getInventoryIds() async {
    if (_uid == null) return [];
    final rows = await _db
        .from('user_inventory')
        .select('item_id')
        .eq('user_id', _uid!);
    return (rows as List).map((r) => r['item_id'] as String).toList();
  }

  // Получить экипированные предметы
  Future<Map<String, String>> getEquipped() async {
    if (_uid == null) return {};
    final rows = await _db
        .from('user_inventory')
        .select('item_id, item_type')
        .eq('user_id', _uid!)
        .eq('is_equipped', true);
    final Map<String, String> result = {};
    for (final r in rows as List) {
      result[r['item_type'] as String] = r['item_id'] as String;
    }
    return result;
  }
}

enum ShopPurchaseResult {
  success,
  notEnoughCoins,
  alreadyOwned,
  notLoggedIn,
  error,
}

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'user_store.dart';

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

    ShopItem(
      id: 'prefix_legenda',
      category: ShopCategory.nickPrefix,
      name: 'LEGENDA',
      description: 'Легендарный золотой префикс — для настоящих легенд',
      price: 500,
      rarity: Rarity.legendary,
      meta: {'color': 0xFFFFD700, 'glow': 0xFFFFD700, 'prefix_text': 'LEGENDA'},
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

  static const _legacyInventoryKey = 'shop_inventory';
  static const _legacyEquippedKey = 'shop_equipped';

  String get _inventoryKey => 'shop_inventory_${_uid ?? 'anon'}';
  String get _equippedKey => 'shop_equipped_${_uid ?? 'anon'}';

  Future<void> _migrateLegacyPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final invKey = _inventoryKey;
      final eqKey = _equippedKey;
      if (prefs.getString(invKey) == null) {
        final legacy = prefs.getString(_legacyInventoryKey);
        if (legacy != null) {
          await prefs.setString(invKey, legacy);
          await prefs.remove(_legacyInventoryKey);
        }
      }
      if (prefs.getString(eqKey) == null) {
        final legacy = prefs.getString(_legacyEquippedKey);
        if (legacy != null) {
          await prefs.setString(eqKey, legacy);
          await prefs.remove(_legacyEquippedKey);
        }
      }
    } catch (_) {}
  }

  // ═══════════════════════════════════════════════════════════════
  //  ПОКУПКА
  // ═══════════════════════════════════════════════════════════════

  Future<ShopPurchaseResult> purchase(ShopItem item) async {
    if (_uid == null) return ShopPurchaseResult.notLoggedIn;

    await _migrateLegacyPrefs();

    // Получаем текущие монеты
    int coins = 0;
    try {
      if (_uid != null) {
        final profile = await _db
            .from('users')
            .select('coins')
            .eq('id', _uid!)
            .maybeSingle()
            .timeout(const Duration(seconds: 4));
        coins = (profile?['coins'] ?? 0) as int;
      }
    } catch (_) {
      return ShopPurchaseResult.error;
    }

    if (coins < item.price) return ShopPurchaseResult.notEnoughCoins;

    // Проверяем не куплено ли уже (локально)
    final owned = await getInventoryIds();
    if (owned.contains(item.id)) return ShopPurchaseResult.alreadyOwned;

    // Списываем монеты в Supabase
    try {
      if (_uid != null) {
        await _db.from('users').update({
          'coins': coins - item.price,
        }).eq('id', _uid!).timeout(const Duration(seconds: 4));
        UserStore.instance.applyDelta(coinsDelta: -item.price);
      }
    } catch (_) {
      return ShopPurchaseResult.error;
    }

    // Сохраняем в локальный инвентарь
    await _addToLocalInventory(item.id);

    // Пытаемся синхронизировать с Supabase (fire-and-forget)
    _syncInventoryToRemote(item);

    return ShopPurchaseResult.success;
  }

  // ═══════════════════════════════════════════════════════════════
  //  ЭКИПИРОВКА
  // ═══════════════════════════════════════════════════════════════

  /// Выдать предметы без списания монет (подписка Legenda, промо).
  Future<void> grantItemsLocally(List<String> itemIds) async {
    await _migrateLegacyPrefs();
    for (final id in itemIds) {
      await _addToLocalInventory(id);
    }
  }

  Future<void> equipById(String itemId) async {
    try {
      final item = ShopCatalog.all.firstWhere((i) => i.id == itemId);
      await equip(item);
    } catch (_) {}
  }

  Future<void> equip(ShopItem item) async {
    // Сохраняем локально
    await _setEquippedLocal(item.category.name, item.id);

    // Обновляем профиль в Supabase (fire-and-forget)
    try {
      if (_uid != null) {
        if (item.category == ShopCategory.avatarFrame) {
          _db.from('users').update({
            'equipped_frame': item.id,
          }).eq('id', _uid!).then((_) {}, onError: (_) {});
        } else if (item.category == ShopCategory.nickPrefix) {
          _db.from('users').update({
            'equipped_prefix': item.id,
            'nick_prefix_color': item.meta['color']?.toString(),
          }).eq('id', _uid!).then((_) {}, onError: (_) {});
        }
      }
    } catch (_) {}
  }

  // Снять предмет
  Future<void> unequip(ShopCategory category) async {
    await _setEquippedLocal(category.name, null);

    try {
      if (_uid != null) {
        if (category == ShopCategory.avatarFrame) {
          _db.from('users').update({
            'equipped_frame': null,
          }).eq('id', _uid!).then((_) {}, onError: (_) {});
        } else if (category == ShopCategory.nickPrefix) {
          _db.from('users').update({
            'equipped_prefix': null,
            'nick_prefix_color': null,
          }).eq('id', _uid!).then((_) {}, onError: (_) {});
        }
      }
    } catch (_) {}
  }

  // ═══════════════════════════════════════════════════════════════
  //  ПОЛУЧЕНИЕ ДАННЫХ
  // ═══════════════════════════════════════════════════════════════

  Future<List<String>> getInventoryIds() async {
    await _migrateLegacyPrefs();
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_inventoryKey);
      if (raw == null) return [];
      final list = jsonDecode(raw);
      if (list is List) return list.cast<String>();
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<Map<String, String>> getEquipped() async {
    await _migrateLegacyPrefs();
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_equippedKey);
      if (raw == null) return {};
      final decoded = jsonDecode(raw);
      if (decoded is Map) {
        return Map<String, String>.from(decoded);
      }
      return {};
    } catch (_) {
      return {};
    }
  }

  // ═══════════════════════════════════════════════════════════════
  //  ЛОКАЛЬНОЕ ХРАНЕНИЕ
  // ═══════════════════════════════════════════════════════════════

  Future<void> _addToLocalInventory(String itemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_inventoryKey);
      final List<String> list = raw != null
          ? List<String>.from(jsonDecode(raw) as List)
          : [];
      if (!list.contains(itemId)) {
        list.add(itemId);
        await prefs.setString(_inventoryKey, jsonEncode(list));
      }
    } catch (_) {}
  }

  Future<void> _setEquippedLocal(String categoryName, String? itemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_equippedKey);
      final Map<String, dynamic> map = raw != null
          ? Map<String, dynamic>.from(jsonDecode(raw) as Map)
          : {};
      if (itemId != null) {
        map[categoryName] = itemId;
      } else {
        map.remove(categoryName);
      }
      await prefs.setString(_equippedKey, jsonEncode(map));
    } catch (_) {}
  }

  void _syncInventoryToRemote(ShopItem item) {
    if (_uid == null) return;
    try {
      _db.from('user_inventory').insert({
        'user_id': _uid,
        'item_id': item.id,
        'item_type': item.category.name,
        'purchased_at': DateTime.now().toIso8601String(),
        'is_equipped': false,
      }).then((_) {}, onError: (_) {});
    } catch (_) {}
  }
}

enum ShopPurchaseResult {
  success,
  notEnoughCoins,
  alreadyOwned,
  notLoggedIn,
  error,
}

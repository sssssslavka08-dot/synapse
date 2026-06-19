# SYNAPSE

Кроссплатформенное приложение для изучения иностранных языков (Flutter + Supabase).

**Демо:** https://synapse-nine-brown.vercel.app  
**APK:** https://synapse-nine-brown.vercel.app/synapse.apk

## Требования

- Flutter SDK 3.13+ (рекомендуется 3.32.x)
- Dart 3.0+
- Android Studio / Xcode (для эмулятора) или Chrome (Web)

## Запуск

```bash
cd synapse
flutter pub get
flutter run
```

Для Web:

```bash
flutter run -d chrome
```

Для Android:

```bash
flutter run -d android
```

Перед запуском создай `lib/config/secrets.dart`:
```bash
cp lib/config/secrets.example.dart lib/config/secrets.dart
```
Заполни URL, anon key и Google Client ID из Supabase / Google Cloud.

Для веб-страниц (лендинг, admin, app):
```bash
cp config/supabase.public.example.js config/supabase.public.js
```

Для Android:
```bash
cp android/app/google-services.json.example android/app/google-services.json
```
Заполни из Firebase Console.

## Безопасность

Не коммить в репозиторий: `secrets.dart`, `config/supabase.public.js`, `google-services.json`.
Если ключи уже попали в публичный git — **смени их** в Supabase и Firebase Dashboard.

## Структура

```
lib/           — исходный код Flutter
assets/        — переводы, изображения, анимации
admin/         — админ-панель (HTML/JS)
web/           — иконки и манифест PWA
index.html     — лендинг
```

## Сборка релиза

```bash
flutter build apk --release
flutter build web --release --base-href="/flutter/"
```

## Технологии

Flutter, Dart, Supabase (PostgreSQL, Auth, RLS), Riverpod, SM-2, Vercel

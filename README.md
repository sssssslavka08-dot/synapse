# SYNAPSE 🧠
### Интеллектуальная языковая платформа

[![Deploy](https://img.shields.io/badge/website-live-brightgreen)](https://synapse-kz.netlify.app)
[![Flutter](https://img.shields.io/badge/Flutter-3.32.5-blue)](https://flutter.dev)
[![Supabase](https://img.shields.io/badge/Supabase-connected-green)](https://supabase.com)

## Скачать приложение
[⬇️ Скачать APK для Android](https://synapse-nine-brown.vercel.app/synapse.apk)

## Ссылки
- 🌐 Сайт: https://synapse-kz.netlify.app
- 📊 Админ-панель: https://synapse-admin.netlify.app
- 📱 App Store: скоро
- 📱 Google Play: скоро

## Технологии
- **Flutter** (iOS + Android) — кроссплатформенное мобильное приложение
- **Supabase** — PostgreSQL база данных + авторизация + RLS
- **Netlify** — хостинг сайта-визитки и админ-панели
- **GitHub Actions** — автоматическая сборка APK + деплой

## Возможности приложения
- 🧠 Интервальное повторение (алгоритм SM-2)
- 🎮 Режимы для детей (≤12): Нейрончик, конструктор слов
- ⚡ Режим выживания для взрослых (60 секунд)
- 🔊 TTS-произношение на 6 языках
- 🏆 Еженедельный рейтинг с лигами
- 📊 AI-аналитика прогресса
- 👑 Система подписок: FREE / PRO / LEGENDA

## Запуск проекта

```bash
git clone https://github.com/sssssslavka08-dot/synapse.git
cd synapse
flutter pub get
flutter run
```

> **Важно:** перед запуском создай файл `lib/config/secrets.dart`:
> ```dart
> const supabaseUrl = 'YOUR_SUPABASE_URL';
> const supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
> ```

## Структура проекта

```
synapse/
├── lib/
│   ├── config/           # secrets.dart (не в git)
│   ├── data/             # локальные данные (слова-заглушки)
│   ├── services/         # Supabase, Words, Notifications
│   └── presentation/
│       └── screens/
│           ├── auth/         # Логин, регистрация
│           ├── home/         # Главный экран + табы
│           ├── games/        # Нейрончик, конструктор, выживание
│           ├── lesson/       # Урок + результат
│           ├── onboarding/   # Welcome screen
│           └── subscription/ # Тарифы
├── admin/                # Админ-панель (HTML/JS)
│   ├── admin.css
│   ├── admin.js
│   ├── index.html
│   ├── dashboard.html
│   ├── users.html
│   ├── words.html
│   ├── analytics.html
│   ├── leaderboard.html
│   └── subscriptions.html
├── index.html            # Сайт-визитка
├── netlify.toml          # Конфиг деплоя Netlify (сайт)
├── render.yaml           # Конфиг деплоя Render
├── .github/
│   └── workflows/
│       ├── deploy.yml    # Автодеплой на Netlify
│       └── build-apk.yml # Сборка APK + GitHub Release
└── README.md
```

## Деплой

### Netlify (сайт-визитка)
1. [netlify.com](https://netlify.com) → **New site from Git**
2. Подключи репозиторий `sssssslavka08-dot/synapse`
3. Branch: `main` | Publish directory: `.`
4. Deploy → сайт будет на `https://synapse-kz.netlify.app`

### Netlify (админ-панель)
1. [netlify.com](https://netlify.com) → **New site from Git**
2. Тот же репозиторий
3. Base directory: `admin` | Publish directory: `admin`
4. Deploy → `https://synapse-admin.netlify.app`

### Render (альтернатива)
1. [render.com](https://render.com) → **New → Static Site**
2. Подключи GitHub | Branch: `main`
3. Publish directory: `admin`
4. Deploy

## GitHub Secrets

В **Settings → Secrets and variables → Actions** добавь:

| Секрет | Значение |
|--------|----------|
| `SUPABASE_URL` | `https://recotdufzxbuffrlluqu.supabase.co` |
| `SUPABASE_KEY` | твой anon key из Supabase |
| `NETLIFY_AUTH_TOKEN` | из [netlify.com/user/applications](https://app.netlify.com/user/applications) |
| `NETLIFY_SITE_ID` | из настроек сайта на Netlify |

## Первый релиз

```bash
git add .
git commit -m "feat: production ready v1.0.0"
git push origin main
git tag v1.0.0
git push origin v1.0.0
```

GitHub Actions автоматически соберёт APK и создаст Release.
Ссылка для скачивания: `https://synapse-nine-brown.vercel.app/synapse.apk`

---
*SYNAPSE v1.0 — © 2024. Все права защищены.*

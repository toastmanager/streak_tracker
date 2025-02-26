# Streak Tracker | Backend

Сервер для Streak Tracker написанный на Nest.js

## 📖 Содежрание

1. [🛠 Технологии](#-технологии)
2. [📦 Установка](#-установка)
3. [🔧 Запуск](#-запуск)
4. [⚙️ Поддержка сервера](#️-поддержка-сервера)
5. [🤝 Команда](#-команда)

## 🛠 Технологии

- [TypeScript](https://www.typescriptlang.org/) - основной язык
- [Node.js](https://nodejs.org) - среда выполнения JavaScript
- [Yarn](https://yarnpkg.com/) - пакетный менеджер
- [Nest.js](https://nestjs.com/) - фреймворк
- [Prisma](https://www.prisma.io/) - ORM
- [Passport.js](https://www.prisma.io/) - библиотека для аутентификации
- [@nestjs/swagger](https://github.com/nestjs/swagger) - модуль для поддержки OpenAPI (Swagger) в Nest.js
- [@itgorillaz/configify](https://github.com/it-gorillaz/configify) - библиотека для упрощённого создания класса конфигурации для Nest.js

## 📦 Установка

```bash
## 1. Клонируйте репозиторий:
git clone https://github.com/toastmanager/streak_tracker.git
## 2. Перейдите в папку с сервером:
cd streak_tracker/backend
## 3. Установите зависимости:
yarn install
## 4. Скопируйте .env.example в .env:
cp .env.example .env
## 5. Запустите сервер в режиме разработки:
yarn start:dev
```

## 🔧 Запуск

1. Настройте `.env` файл
2. Скопируйте файл `Caddyfile.example` в `Caddyfile`
3. Настройте `Caddyfile` ([Документация](https://caddyserver.com/docs/caddyfile))
4. Запустите сервер
   ```bash
   docker compose up -d --build backend
   ```
   - `-d` запускает контейнеры в фоновом режиме
   - `--build backend` создаёт новую сборку сервера

## ⚙️ Поддержка сервера

### Перенос базы данных

Возможно, вам потребуется перенести данные в другое место. Здесь представлен способ переноса данных из одного postgres контейнера, запущенного docker-compose, в другой. Но по тому же принципу можно перенести данные в экземпляр postgres запущенном не в docker-compose.

1. Создайте dump файл. В нём будут находится все команды нужные для восстановления базы данных.
   ```bash
   docker compose exec db pg_dump -U username -F t dbname > dump.sql
   ```
2. Перенесите `dump.sql` в папку где находится новая база данных.
3. Очистите новую базу данных. **Восстановить удалённые данные из новой базы данных не получится.**
   ```bash
   docker compose exec db dropdb 'dbname'
   docker compose exec db createdb 'dbname'
   ```
4. Внесите изменения в новую базу данных из dump файла.
   ```bash
   docker compose exec -T db psql -U username dbname < dump.sql
   ```

## 🤝 Команда

| Фамилия Имя     | Роль        |
| --------------- | ----------- |
| Габышев Николай | Разработчик |

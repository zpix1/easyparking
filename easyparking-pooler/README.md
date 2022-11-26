# Pooler

## Environment Variables
* `S3_ACCESS_KEY`, `S3_SECRET_KEY` - токены авторизации в minio.
Для локальной разработки: запускаем minio, заходим на `localhost:9001/access-keys` и добавляем ключ.

## Setup For Development In Docker
Команды выполнять из директории `easyparking-pooler`.
```
docker build --build-arg S3_ACCESS_KEY=... --build-arg S3_SECRET_KEY=... -f Dockerfile.dev -t pooler .
docker run --name pooler -v $(pwd)/.mnesia:/app/.mnesia -p 4000:4000 -d pooler:latest
```
Посмотреть документацию и потестить API можно на `localhost:4000/swaggerui`.

## DB Reset
При обновлении схемы БД может иметь смысл сделать reset. Также при ресете создаются тестовые данные парковок.

1. Подключимся к контейнеру
```
docker exec -it pooler /bin/sh
```
2. Подключимся к консоли и получим доступ к рантайму.
```
iex --sname console --cookie monster --remsh dev
```
3. Вызовем функцию для популяции базы данных парковок
```
Pooler.Helper.Seeds.seed
```

Тут же можно убедиться, что парковки были созданы
```
Pooler.Parking.list_all
```
 
## Commands
### Install Dependencies
```
mix deps.get
```
### Run Server For Development
```
iex -S mix phx.server
```
### Format
```
mix format
```
### Run Tests
```
mix test
```
### Test Coverage
```
mix coveralls
```
### Static Code Analysis - Consistency
```
mix credo --strict
```
### Static Code Analysis - Types
```
mix dialyzer
```
### Docs Quality Check
```
mix inch
```
### Docs Generation
```
mix docs
```

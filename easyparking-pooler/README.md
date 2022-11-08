# Pooler

## Setup For Development In Docker
Команды выполнять из директории `easyparking-pooler`.
```
docker build -f Dockerfile.dev -t pooler .
docker run --name pooler -v $(pwd)/.mnesia:/app/.mnesia -p 4000:4000 -d pooler:latest
```
Посмотреть документацию и потестить API можно на `localhost:4000/swaggerui`.
 
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

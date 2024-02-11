# Start containers
up:
	docker compose up -d

# Stop containers
down:
	docker compose down --remove-orphans

# Build containers
build:
	docker compose build --no-cache

php:
	docker compose exec -u 1000 php-fpm /bin/bash

php_root:
	docker compose exec php-fpm /bin/bash

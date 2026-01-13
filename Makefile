.PHONY: bash up down build logs

bash:
	docker compose exec dev bash

up:
	docker compose up -d dev

down:
	docker compose down

build:
	docker compose build dev

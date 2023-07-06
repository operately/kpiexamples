PORT ?= 5000
DB_URL = export DATABASE_URL=postgres://postgres:keyboard-cat@localhost:5432 &&

#
# development commands

dev.setup: start.db
	bundle install
	$(DB_URL) bin/rails db:create
	$(DB_URL) bin/rails db:migrate
	$(DB_URL) bin/rails db:seed

dev.server: start.db
	$(DB_URL) bundle exec rails server --port $(PORT)

#
# database utilities

start.db:
	docker compose up -d
	sleep 5

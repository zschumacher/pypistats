build:
	docker-compose build

up:
	docker-compose up

serve:
	poetry run uvicorn pypistats:app --reload

fmt:
	poetry run black --exclude .venv .

setup:
	poetry install

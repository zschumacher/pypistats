build:
	# be sure to pip install poetry!
	poetry install

serve:
	poetry run uvicorn pypistats:app --reload

fmt:
	poetry run black --exclude .venv .

setup:
	asdf install
	poetry install
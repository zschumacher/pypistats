make build:
	# be sure to pip install poetry!
	poetry install

make serve:
	poetry run uvicorn pypistats:app --reload

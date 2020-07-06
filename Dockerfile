FROM python:3.8.3-slim

RUN apt-get update && \
    apt-get install curl -y && \
    apt-get clean

# Set the working directory to app
WORKDIR /app

# Create a python user so we aren't runnning as root
RUN useradd -m python && \
  chown python:python -R /app
USER python

# Set the poetry version explicitly
ENV POETRY_VERSION=1.0.9
# Unbuffer the logger so we always get logs
ENV PYTHONUNBUFFERED=1
# Update the path for poetry python
ENV PATH=/home/python/.poetry/bin:/home/python/.local/bin:$PATH

# Install vendored poetry
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

# Add dep configs
ADD ./pyproject.toml .
ADD ./poetry.lock .

# Install packages
# Disable virtualenv creation so we just use the already-installed python
RUN poetry config virtualenvs.create false && \
    poetry run pip install --user -U pip && \
    poetry install --no-dev

# Add everything
ADD . .

# Expose port
EXPOSE 8000

# Set the entrypoint to the bootstrapper
ENTRYPOINT ["./docker-entrypoint.sh"]
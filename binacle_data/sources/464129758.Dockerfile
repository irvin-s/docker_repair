FROM python:3.7-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PIP_NO_BINARY psycopg2

WORKDIR /src
RUN mkdir /static

COPY Pipfile* /src/

RUN apt-get update \
    && apt-get install -y libpq-dev python3-websocket gcc \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --upgrade pip \
    && pip install pipenv \
    && pipenv install --system --deploy --dev \
    && apt-get purge -y --auto-remove gcc

COPY src /src

EXPOSE 8000
CMD python manage.py collectstatic --no-input;python manage.py makemigrations;\
    python manage.py migrate;\
    gunicorn pyback.wsgi -b 0.0.0.0:8000 -w 3 --access-logfile=- --error-logfile=- --capture-output --logger-class "pyback.log.CustomGunicornLogger"

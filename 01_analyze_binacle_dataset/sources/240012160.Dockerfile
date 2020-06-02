FROM python:3.6-alpine3.7

ENV PYTHONUNBUFFERED 1

COPY ./Pipfile* /

RUN apk add --no-cache bash ca-certificates wget build-base python3-dev postgresql-dev libffi-dev libressl-dev \
    && wget https://s3.amazonaws.com/rds-downloads/rds-ca-2015-root.pem -P /usr/local/share/ca-certificates/ \
    && mv /usr/local/share/ca-certificates/rds-ca-2015-root.pem /usr/local/share/ca-certificates/rds-ca-2015-root.crt \
    && update-ca-certificates \
    && pip install --upgrade pip \
    && pip install pipenv \
    && pipenv install --ignore-pipfile --dev --system \
    && apk del --purge build-base python3-dev

COPY ./compose/django/entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r//' /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY ./compose/django/start-dev.sh /start-dev.sh
RUN sed -i 's/\r//' /start-dev.sh
RUN chmod +x /start-dev.sh

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]

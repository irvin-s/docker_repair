FROM python:3.6-alpine3.7

LABEL maintainer="Jose Armesto <jose@armesto.net>"

EXPOSE 5000

ENV PYTHONUNBUFFERED 1

WORKDIR /app
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["gunicorn", "--config", "./conf/gunicorn_config.py", "app:app"]

COPY requirements.txt ./app
RUN apk add --update ca-certificates tini=0.17.0-r0; \
    pip install -r requirements.txt; \
    rm -rf /var/cache/apk/* /tmp/*
COPY . /app

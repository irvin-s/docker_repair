# Redash v6.0
# docker run --rm -p 5000:5000 supinf/redash:core-6.0

FROM ubuntu:xenial-20181005

ENV REDASH_VERSION=v6.0.0 \
    REDASH_HOST= \
    REDASH_CSV_WRITER_ENCODING=utf-8 \
    REDASH_WEB_WORKERS=1 \
    WORKERS_COUNT=1 \
    REDASH_ALLOW_SCRIPTS_IN_USER_INPUT=true \
    QUEUES=queries,scheduled_queries,celery \
    REDASH_LOG_LEVEL=INFO \
    PYTHONUNBUFFERED=0

WORKDIR /app
EXPOSE 5000

# git clone Redash v6.0
RUN apt-get update \
    && apt-get install -y git \
    && git clone --depth=1 -b ${REDASH_VERSION} https://github.com/getredash/redash.git /app \
    && rm -rf tests old_migrations setup ./*.md ./*.yml ./.* 2>/dev/null | true \
    && apt-get remove --purge -y git && apt autoremove -y \
    && rm -rf /var/cache

# Solve server dependencies
# @see https://github.com/getredash/docker/blob/master/base/Dockerfile
RUN mkdir -p /var/cache/apt \
    && apt-get install -y python libmysqlclient-dev python-pip libsasl2-dev \
    && pip install -r requirements.txt -r requirements_all_ds.txt \
    && pip install -U setuptools==23.1.0 \
    && apt-get remove --purge -y python-pip libsasl2-dev \
    && apt autoremove -y \
    && find / -type d -name tests -depth -exec rm -rf {} \; \
    && find / -type d -name test -depth -exec rm -rf {} \; \
    && find / -type d -name \__pycache__ -depth -exec rm -rf {} \; \
    && rm -rf /var/cache /root/.cache

# Solve client dependencies
RUN mkdir -p /var/cache/apt \
    && apt-get install -y curl \
    && curl --silent --show-error https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs git \
    && npm install && npm run build \
    && apt-get remove --purge -y nodejs git curl \
    && apt autoremove -y \
    && rm -rf node_modules /var/cache /root/.npm /tmp/*

RUN adduser --system --group redash \
    && chown -R redash /app

USER redash

ENTRYPOINT ["/app/bin/docker-entrypoint"]
CMD ["help"]

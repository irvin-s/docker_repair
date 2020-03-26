FROM python:2.7

RUN apt-get update -qq && \
    apt-get install -y libpq-dev python-dev mysql-client netcat openjdk-8-jre

ARG userid=999
ARG groupid=999

RUN groupadd --gid $groupid hostgroup && \
    useradd --no-log-init --uid $userid --gid $groupid appuser
RUN mkdir -p /project/catalog-api \
             /project/logs \
             /project/media \
             /project/requirements && \
    chown -R appuser:hostgroup /project

WORKDIR /project/catalog-api

RUN git clone https://github.com/vishnubob/wait-for-it.git ../wait-for-it

COPY requirements/* /project/requirements/

RUN pip install -r /project/requirements/requirements-base.txt \
                -r /project/requirements/requirements-dev.txt \
                -r /project/requirements/requirements-tests.txt

ENV PYTHONPATH=/project/catalog-api \
    LOG_FILE_DIR=/project/logs \
    MEDIA_ROOT=/project/media \
    PATH=$PATH:/project/wait-for-it \
    DEFAULT_DB_HOST=default-db-dev \
    DEFAULT_DB_PORT=3306 \
    TEST_DEFAULT_DB_HOST=default-db-test \
    TEST_DEFAULT_DB_PORT=3306 \
    TEST_SIERRA_DB_HOST=sierra-db-test \
    TEST_SIERRA_DB_PORT=5432 \
    SOLR_HOST=solr-dev \
    SOLR_PORT=8983 \
    TEST_SOLR_HOST=solr-test \
    TEST_SOLR_PORT=8983 \
    REDIS_CELERY_HOST=redis-celery \
    REDIS_CELERY_PORT=6379 \
    REDIS_APPDATA_HOST=redis-appdata-dev \
    REDIS_APPDATA_PORT=6379 \
    TEST_REDIS_APPDATA_HOST=redis-appdata-test \
    TEST_REDIS_APPDATA_PORT=6379

USER appuser

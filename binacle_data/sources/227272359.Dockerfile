FROM python:3.5.2-alpine
MAINTAINER Miku Laitinen <miku@avoin.systems>

RUN apk update \
    && apk add python py-pip bash \
    && pip install boto3 requests ConfigArgParse \
    && apk add curl \
    && curl -L --insecure https://github.com/odise/go-cron/releases/download/v0.0.6/go-cron-linux.gz | zcat > /usr/local/bin/go-cron \
    && chmod u+x /usr/local/bin/go-cron \
    && apk del curl \
    && apk del py-pip \
    && rm -rf /var/cache/apk/*

ENV ODOO_HOST 'odoo'
ENV ODOO_PORT '8069'
ENV ODOO_MASTER_PASSWORD 'admin'
ENV ODOO_VERSION '11'

# A comma separated list of databases to backup
ENV DATABASES ''

ENV AWS_ACCESS_KEY_ID ''
ENV AWS_SECRET_ACCESS_KEY ''
ENV AWS_REGION 'eu-central-1'
ENV S3_BUCKET ''
ENV S3_PATH 'backup'
ENV RESTORE_FILENAME ''

ENV SCHEDULE 'single'
ENV CHECK_URL ''

# USER backup

COPY run.sh /run.sh
COPY backup.py /backup.py
COPY wait-for-it.sh /wait-for-it.sh

ENTRYPOINT ["/run.sh"]
CMD ["backup"]

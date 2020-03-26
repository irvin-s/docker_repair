FROM node:carbon-alpine AS frontend
WORKDIR /opt/app/
COPY package.json /opt/app/
RUN apk --no-cache add --virtual native-deps \
  g++ make python && \
  npm install --quiet --production && \
  apk del native-deps
COPY . /opt/app/
RUN npm run build

FROM python:3.6-alpine3.8
WORKDIR /opt/app/
COPY requirements.txt /opt/app/
RUN apk --no-cache add --virtual .python-rundeps \
        libpq \
        libjpeg \
        zlib \
        postgresql \
        build-base \
        cairo-dev \
        cairo \
        cairo-tools \
        openjpeg-dev \
        openssl \
        tiff-dev \
        libxslt-dev \
        libxml2-dev \
    && apk --no-cache add --virtual .build-deps \
        gcc \
        make \
        musl-dev \
        linux-headers \
        postgresql-dev \
        jpeg-dev \
        zlib-dev \
        libffi-dev \
        freetype-dev \
        lcms2-dev \
        tk-dev \
        tcl-dev \
        py-lxml \
    && python3 -m venv /opt/django-venv \
    && /opt/django-venv/bin/pip install -r /opt/app/requirements.txt \
    && apk del .build-deps
COPY . /opt/app/
# Copy CSS & compiled JavaScript
COPY --from=frontend /opt/app/assets assets
COPY config/docker-entry.sh /docker-entry.sh
ENV DOCKERIZE_VERSION v0.6.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz
RUN mkdir -p /var/lib/celery && \
    addgroup -g 1000 -S celery && \
    adduser -u 1000 -S celery -G celery && \
    chown celery:celery /var/lib/celery/
RUN /opt/django-venv/bin/python /opt/app/manage.py compilemessages -l de
ENV DATABASE_URL="sqlite:////var/app/db.sqlite3" \
    ADMIN_EMAIL="" \
    SECRET_KEY="" \
    EMAIL_HOST="" \
    EMAIL_HOST_USER="" \
    EMAIL_HOST_PASSWORD="" \
    TWILIO_ACCOUNT_SID="" \
    TWILIO_AUTH_TOKEN="" \
    TWILIO_NUMBER="" \
    BROKER_URL="amqp://guest:guest@rabbitmq//" \
    BACKUP_DIR="/tmp" \
    BACKUP_AWS_ACCESS_KEY_ID="" \
    BACKUP_AWS_SECRET_ACCESS_KEY="" \
    BACKUP_AWS_STORAGE_BUCKET_NAME="" \
    BACKUP_AWS_KEY_PREFIX=""
EXPOSE 80
VOLUME /var/app/static_serve
VOLUME /var/app/upload
VOLUME /var/lib/celery/
ENTRYPOINT ["/docker-entry.sh"]
CMD ["/opt/django-venv/bin/gunicorn", "learnwithpeople.wsgi:application", "--bind", "0.0.0.0:80", "--workers=3"]

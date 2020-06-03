# Redash v6.0 (All-in-One)
# docker run --rm -p 5000:5000 -p 5432:5432 supinf/redash:6.0
# docker run --rm -p 5000:5000 -e REDASH_MAIL_SERVER=email-smtp.us-east-1.amazonaws.com -e REDASH_MAIL_PORT=465 -e REDASH_MAIL_USE_TLS=true -e REDASH_MAIL_USE_SSL=true -e REDASH_MAIL_USERNAME=user -e REDASH_MAIL_PASSWORD=pass -e REDASH_MAIL_DEFAULT_SENDER=no-reply@example.com supinf/redash:6.0

FROM supinf/redash:core-6.0

ENV REDASH_DATABASE_URL=postgresql://postgres@localhost:5432/postgres \
    REDASH_REDIS_URL=redis://localhost:6379/0 \
    REDIS_VERSION=5.0.3 \
    S6_VERSION=v1.21.7.0 \
    S6_LOGGING=1

USER root

# Install s6-overlay for running multiple processes in a container
RUN mkdir -p /var/cache/apt \
    && apt-get install -y gnupg2 curl \
    && s6_dl=https://github.com/just-containers/s6-overlay/releases/download \
    && s6_tar=s6-overlay-amd64.tar.gz \
    && curl --location --silent --show-error -O "${s6_dl}/${S6_VERSION}/${s6_tar}" \
    && curl --location --silent --show-error -O "${s6_dl}/${S6_VERSION}/${s6_tar}.sig" \
    && curl --location --silent --show-error https://keybase.io/justcontainers/key.asc | gpg --import \
    && gpg --verify ${s6_tar}.sig ${s6_tar} \
    && tar xzf ${s6_tar} -C / \
    && apt-get remove --purge -y gnupg2 curl \
    && apt autoremove -y \
    && rm -rf ${s6_tar} ${s6_tar}.sig /var/cache

# Install PostgreSQL v9.5
RUN mkdir -p /var/cache/apt \
    && apt-get install -y postgresql postgresql-contrib \
    && echo "host  all  postgres  0.0.0.0/0  trust" > /etc/postgresql/9.5/main/pg_hba.conf \
    && echo "host  all  redash    0.0.0.0/0  trust" >> /etc/postgresql/9.5/main/pg_hba.conf \
    && echo "listen_addresses='*'" >> /etc/postgresql/9.5/main/postgresql.conf \
    && echo "stats_temp_directory='/tmp'" >> /etc/postgresql/9.5/main/postgresql.conf \
    && rm -rf /var/cache

# Install Redis v5.0
RUN mkdir -p /var/cache/apt \
    && apt-get install -y build-essential curl tcl \
    && cd /tmp \
    && curl --location --silent --show-error -O \
       "http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz" \
    && tar xzf "redis-${REDIS_VERSION}.tar.gz" \
    && cd "redis-${REDIS_VERSION}" \
    && make && make install \
    && mkdir /etc/redis \
    && cp "/tmp/redis-${REDIS_VERSION}/redis.conf" /etc/redis \
    && adduser --system --group --no-create-home redis \
    && mkdir -p /var/lib/redis \
    && chown redis:redis /var/lib/redis \
    && chmod 770 /var/lib/redis \
    && apt-get remove --purge -y build-essential curl tcl \
    && apt autoremove -y \
    && cd / \
    && rm -rf /var/cache /tmp/*

# Configure user services with /etc/services.d/
RUN mkdir -p /etc/services.d/postgres \
    && echo "#!/usr/bin/with-contenv sh\n\
s6-setuidgid postgres /usr/lib/postgresql/9.5/bin/postgres \
-D /var/lib/postgresql/9.5/main \
-c config_file=/etc/postgresql/9.5/main/postgresql.conf" \
      > /etc/services.d/postgres/run

RUN mkdir -p /etc/services.d/redis \
    && echo "#!/usr/bin/with-contenv sh\n\
/usr/local/bin/redis-server /etc/redis/redis.conf" \
      > /etc/services.d/redis/run

RUN mkdir -p /etc/services.d/celery-worker \
    && echo "#!/usr/bin/with-contenv sh\n\
sleep 3\n\
cd /app\n\
s6-setuidgid postgres /app/bin/docker-entrypoint create_db\n\
s6-setuidgid redash /app/bin/docker-entrypoint scheduler" \
      > /etc/services.d/celery-worker/run

EXPOSE 5432

ENTRYPOINT ["/init"]
CMD ["s6-setuidgid", "redash", "/app/bin/docker-entrypoint", "server"]

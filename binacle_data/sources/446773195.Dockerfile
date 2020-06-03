FROM openjdk:8

MAINTAINER Daniel E. Renfer <duck@kronkltd.net>
ENV APP_HOME /app
WORKDIR ${APP_HOME}

# Install dependencies
RUN set -x \
    && apt-get update \
    && apt-get install -y \
       netcat \
    && rm -rf /var/lib/apt/lists/*

# Default application settings
ENV JIKSNU_DB_HOST mongo
ENV HTTP_PORT 8080

# Expose HTTP port
EXPOSE 8080

### Create application user
ARG user=jiksnu
ARG group=jiksnu
ARG uid=1000
ARG gid=1000
RUN groupadd -g ${gid} ${group} \
    && useradd -u ${uid} -g ${gid} --create-home -s /bin/bash ${user}

COPY config                ${APP_HOME}/config
COPY script                ${APP_HOME}/script
COPY jiksnu.jar            ${APP_HOME}/jiksnu.jar
RUN chown -R ${uid}:${gid} ${APP_HOME}

USER ${user}

### Set start script
ENTRYPOINT [ "script/entrypoint-run" ]

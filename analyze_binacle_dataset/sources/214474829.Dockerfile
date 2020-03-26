FROM esycat/java:8-openjdk-alpine

MAINTAINER "Eugene Janusov" <esycat@gmail.com>

ARG APP_VERSION=2018.2
ARG APP_BUILD=43142

LABEL \
    version="${APP_VERSION}.${APP_BUILD}" \
    com.esyfur.jetbrains-hub-version="${APP_VERSION}.${APP_BUILD}" \
    com.esyfur.vcs-url="https://github.com/esycat/docker-youtrack"

ENV APP_NAME=youtrack \
    APP_PORT=8080 \
    APP_UID=500 \
    APP_PREFIX=/opt

ENV APP_USER=$APP_NAME \
    APP_DIR=$APP_PREFIX/$APP_NAME \
    APP_HOME=/var/lib/$APP_NAME

# preparing home (data) directory and user+group
RUN useradd --system --user-group --uid $APP_UID --home $APP_HOME $APP_USER && \
    mkdir $APP_HOME && \
    chown -R $APP_USER:$APP_USER $APP_HOME

WORKDIR $APP_PREFIX

# downloading build dependencies,
# downloading and unpacking the distribution, changing file permissions, removing bundled JVMs,
# removing build dependencies
RUN apk add -q --no-cache --virtual .build-deps wget unzip && \
    wget -qO ${APP_NAME}.zip https://download.jetbrains.com/charisma/youtrack-${APP_VERSION}.${APP_BUILD}.zip && \
    unzip -q ${APP_NAME}.zip -x */internal/java/* && \
    mv youtrack-${APP_VERSION}.${APP_BUILD} $APP_NAME && \
    chown -R $APP_USER:$APP_USER $APP_DIR && \
    rm ${APP_NAME}.zip && \
    apk del .build-deps

USER $APP_USER
WORKDIR $APP_DIR

# configuring the application
RUN bin/youtrack.sh configure \
    --backups-dir $APP_HOME/backups \
    --data-dir    $APP_HOME/data \
    --logs-dir    $APP_HOME/log \
    --temp-dir    $APP_HOME/tmp \
    --listen-port $APP_PORT \
    --base-url    http://localhost/

EXPOSE $APP_PORT
VOLUME ["$APP_HOME"]
ENTRYPOINT ["bin/youtrack.sh"]
CMD ["run"]

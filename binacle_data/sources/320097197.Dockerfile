FROM esycat/java:alpine-openjre

MAINTAINER "Eugene Janusov" <esycat@gmail.com>

ARG APP_VERSION=2018.1
ARG APP_BUILD=8691

LABEL \
    version="${APP_VERSION}.${APP_BUILD}" \
    com.esyfur.jetbrains-hub-version="${APP_VERSION}.${APP_BUILD}" \
    com.esyfur.vcs-url="https://github.com/esycat/docker-jetbrains-hub"

ENV APP_NAME=hub \
    APP_PORT=8080 \
    APP_UID=500 \
    APP_PREFIX=/opt \
    APP_DISTNAME="hub-${APP_VERSION}.${APP_BUILD}"

ENV APP_USER=$APP_NAME \
    APP_DIR=$APP_PREFIX/$APP_NAME \
    APP_HOME=/var/lib/$APP_NAME \
    APP_DISTFILE="${APP_DISTNAME}.zip"

# preparing home (data) directory and user+group
RUN useradd --system --user-group --uid $APP_UID --home $APP_HOME $APP_USER && \
    mkdir $APP_HOME && \
    chown -R $APP_USER:$APP_USER $APP_HOME

WORKDIR $APP_PREFIX

# downloading build dependencies,
# downloading and unpacking the distribution, changing file permissions, removing bundled JVMs,
# removing build dependencies
RUN apk add -q --no-cache --virtual .build-deps wget unzip && \
    wget -q https://download.jetbrains.com/hub/$APP_DISTFILE && \
    unzip -q $APP_DISTFILE -x */internal/java/* && \
    mv $APP_DISTNAME $APP_NAME && \
    chown -R $APP_USER:$APP_USER $APP_DIR && \
    rm $APP_DISTFILE && \
    apk del .build-deps

USER $APP_USER
WORKDIR $APP_DIR

# configuring the application
RUN bin/hub.sh configure \
    --backups-dir $APP_HOME/backups \
    --data-dir    $APP_HOME/data \
    --logs-dir    $APP_HOME/log \
    --temp-dir    $APP_HOME/tmp \
    --listen-port $APP_PORT \
    --base-url    http://localhost/

ENTRYPOINT ["bin/hub.sh"]
CMD ["run"]
EXPOSE $APP_PORT
VOLUME ["$APP_HOME"]

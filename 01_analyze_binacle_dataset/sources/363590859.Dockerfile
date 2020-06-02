FROM dzwicker/docker-ubuntu:latest
MAINTAINER email@daniel-zwicker.de

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN \
    mkdir -p /var/lib/upsource && \
    groupadd --gid 2000 upsource && \
    useradd --system -d /var/lib/upsource --uid 2000 --gid upsource upsource && \
    chown -R upsource:upsource /var/lib/upsource

######### Install hub ###################
COPY entry-point.sh /entry-point.sh

RUN \
    export UPSOURCE_VERSION=3.5.3597 && \
    mkdir -p /usr/local && \
    mkdir -p /var/lib/upsource && \
    cd /usr/local && \
    curl -L https://download.jetbrains.com/upsource/upsource-${UPSOURCE_VERSION}.zip > upsource.zip && \
    unzip upsource.zip && \
    mv upsource-${UPSOURCE_VERSION} /usr/local/upsource && \
    echo "$UPSOURCE_VERSION" > /usr/local/upsource/version.docker.image && \
    rm -f upsource.zip && \
    rm -rf /usr/local/upsource/internal/java/linux-x64/man && \
    rm -rf /usr/local/upsource/internal/java/mac-x64 && \
    rm -rf /usr/local/upsource/internal/java/windows-amd64 && \
    chown -R upsource:upsource /usr/local/upsource && \
    chmod -R u+rwxX /usr/local/upsource/internal/java/linux-x64

USER upsource
ENV HOME=/var/lib/upsource
EXPOSE 8080
ENTRYPOINT ["/entry-point.sh"]
CMD ["run"]

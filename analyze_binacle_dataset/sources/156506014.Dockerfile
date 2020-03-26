FROM alpine:3.8

ARG DOCKER_CLI_VERSION="18.06.1-ce"
ENV DOWNLOAD_URL="https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_CLI_VERSION.tgz"

# Docker Client : https://github.com/Cethy/alpine-docker-client
RUN apk --update add curl \
    && mkdir -p /tmp/download \
    && curl -L $DOWNLOAD_URL | tar -xz -C /tmp/download \
    && mv /tmp/download/docker/docker /usr/local/bin/ \
    && rm -rf /tmp/download \
    && apk del curl

# Install zip
RUN apk add zip

# Remove apk cache
RUN rm -rf /var/cache/apk/*

# Cron : https://stackoverflow.com/questions/37015624/how-to-run-a-cron-job-inside-a-docker-container
RUN mkdir /scripts
ADD scripts /scripts
RUN chmod -R 755 /scripts
ADD crontab.txt /crontab.txt
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
RUN /usr/bin/crontab /crontab.txt

CMD ["/entrypoint.sh"]
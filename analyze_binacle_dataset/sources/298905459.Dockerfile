FROM node:6-slim

MAINTAINER Lam Chan

EXPOSE 8080

ENV APPDIR /opt/app/current
WORKDIR $APPDIR

ENTRYPOINT ["docker-shell"]

RUN \
    curl https://kubernetes-helm.storage.googleapis.com/helm-v2.3.1-linux-amd64.tar.gz > /tmp/helm.tar.gz && \
    tar zxvf /tmp/helm.tar.gz -C /tmp && \
    mv /tmp/linux-amd64/helm /usr/local/bin && \
    rm -rf /tmp/linux-amd64 && rm /tmp/helm.tar.gz

COPY ./docker/docker-shell.sh /usr/local/bin/docker-shell
RUN chmod +x /usr/local/bin/docker-shell

COPY ./package.json package.json
RUN npm install --production

COPY . $APPDIR

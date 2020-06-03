FROM debian:jessie-slim

ARG KOEL_VERSION=3.5.4
ARG NODE_VERSION=6.9.4

EXPOSE 8000
VOLUME ["/config","/media"]
WORKDIR /opt

RUN apt-get update \
    && apt-get install -y \
    wget \
    unzip \
    php5 \
    php5-curl \
    php5-mysql \
    php5-pgsql \
    python \
    make \
    g++ \
    xz-utils \
    gettext \
    jq \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/cache /var/lib/log

ENV DOCKERIZE_VERSION v0.3.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN wget https://getcomposer.org/installer \
    && php installer \
    && mv composer.phar /usr/local/bin/composer \
    && rm installer

RUN wget https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz \
    && tar -xvf node-v$NODE_VERSION-linux-x64.tar.xz -C /opt \
    && mv node-v$NODE_VERSION-linux-x64 nodejs \
    && rm node-v$NODE_VERSION-linux-x64.tar.xz \
    && ln -sf /opt/nodejs/bin/node /usr/bin/node \
    && ln -sf /opt/nodejs/bin/npm /usr/bin/npm

RUN npm install -g yarn \
   && ln -sf /opt/nodejs/bin/yarn /usr/bin/yarn

RUN wget https://github.com/phanan/koel/archive/v$KOEL_VERSION.zip \
    && unzip -o v$KOEL_VERSION.zip -d /opt \
    && rm v$KOEL_VERSION.zip

WORKDIR /opt/koel-$KOEL_VERSION

RUN composer install

# skipping yarn install while launching the app
RUN sed -i 's/yarn/#yarn/g' /opt/koel-$KOEL_VERSION/app/Console/Commands/Init.php \
    && yarn install \
    && npm prune --production

COPY template/.env.docker .env.template
COPY bin /bin
RUN chmod +x /bin/*.sh
CMD /bin/docker-entrypoint.sh

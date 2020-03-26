# blueriver/docker-muracms:7.1-lucee5
FROM lucee/lucee5:latest

ENV APP_DIR="/var/www"

RUN apt-get update && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/* \
    && git clone --branch 7.1 --single-branch --depth 1 https://github.com/blueriver/MuraCMS.git \
    && cp -R MuraCMS/. ${APP_DIR} \
    && rm -rf MuraCMS

EXPOSE 8888
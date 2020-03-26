# blueriver/docker-muracms:7.1-commandbox-lucee5
FROM ortussolutions/commandbox:lucee5

ENV APP_DIR="/app"

RUN apt-get update && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/* \
    && git clone --branch 7.1 --single-branch --depth 1 https://github.com/blueriver/MuraCMS.git \
    && cp -R MuraCMS/. ${APP_DIR} \
    && rm -rf MuraCMS

EXPOSE 8080 8443

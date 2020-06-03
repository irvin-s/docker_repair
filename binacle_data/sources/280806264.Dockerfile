ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache jq wget git nodejs nodejs-npm
RUN mkdir -p /usr/src/landroid-bridge
WORKDIR /usr/src/landroid-bridge

RUN cd /usr/src && \
    git clone https://github.com/virtualzone/landroid-bridge.git && \
    cd /usr/src/landroid-bridge

RUN apk --no-cache --virtual build-dependencies add \
    python \
    make \
    g++ \
    && npm install \
    && apk del build-dependencies

RUN npm run build-prod

COPY run.sh /
RUN chmod a+x /run.sh

COPY config_template.json /usr/src/landroid-bridge/config.json

VOLUME /data

EXPOSE 3000

CMD [ "/run.sh" ]

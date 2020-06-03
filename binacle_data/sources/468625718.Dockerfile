ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache jq nodejs git openssh-keygen curl

RUN curl -o /waiting https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
    chmod +x /waiting

RUN mkdir /node-red && \
    cd /node-red && \
    npm install --no-optional --only=production node-red@0.18.4 bcryptjs && \
    npm cache clear --force && \
    mkdir /node-temp && \
    cd /node-temp && \
    npm install --no-optional --only=production node-red-contrib-home-assistant@0.2.1 && \
    npm install --no-optional --only=production node-red-contrib-home-assistant@0.3.0 && \
    npm install --no-optional --only=production node-red-contrib-home-assistant@0.3.2 && \
    cd / && \
    rm -Rf /node-temp

ENV PALETTE_VERSIONS="0.2.1 0.3.0 0.3.2"

WORKDIR /data

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

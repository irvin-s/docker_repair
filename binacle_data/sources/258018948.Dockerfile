FROM alpine

RUN apk update
RUN apk add \
    ca-certificates \
    wget
RUN update-ca-certificates
RUN apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apk del tzdata

ARG SISITO_API_VERSION=0.2.8
RUN wget -O - -q https://github.com/winebarrel/sisito-api/releases/download/v${SISITO_API_VERSION}/sisito-api-v${SISITO_API_VERSION}-linux-amd64.gz \
      | gunzip > /sbin/sisito-api && \
    chmod +x /sbin/sisito-api

COPY docker/sisito-api/ /

CMD ["/sbin/sisito-api", "-config", "/etc/sisito-api.toml"]

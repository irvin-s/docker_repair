FROM nginx:1.13.3-alpine

RUN mkdir -p /data/nginx/cache && \
    apk add --no-cache curl

HEALTHCHECK --interval=12s --timeout=12s --start-period=30s \
 CMD curl --fail --max-time 10 -k https://localhost || exit 1

COPY certs/ /etc/ssl/
COPY nginx.conf /etc/nginx/nginx.conf
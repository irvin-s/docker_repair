FROM alpine:3.3

ADD app /app
WORKDIR /app

RUN apk --update add bash curl grep uwsgi-cgi && \
    adduser -h /app -s /bin/bash -D ganesh ganesh && \
    chown -R ganesh:ganesh /app

USER ganesh
EXPOSE 9090
CMD uwsgi --ini ganesh.ini

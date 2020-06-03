# This version is for Heroku
FROM alpine:latest
RUN apk add --no-cache --update curl bash && \
    curl https://i.jpillora.com/cloud-torrent! | bash

RUN adduser -D myuser
USER myuser

CMD cloud-torrent

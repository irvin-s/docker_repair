FROM scaleway/alpine:3.2
RUN apk add --update bash socat && rm -rf /var/cache/apk/*
ADD run.sh /usr/local/bin/run
ENV PORT=2375
EXPOSE $PORT
ENTRYPOINT ["/usr/local/bin/run"]
##########################
## Alpine based OPENSSH ##
##########################
FROM alpine:edge
MAINTAINER Chamunks <Chamunks@gmail.com>
## Prepare ##
RUN apk add --update rtorrent && \
    mkdir ~/session
COPY rtorrent.rc ~/.rtorrent.rc
# Port 49164 is opening incoming connections from other peers.
# Port 6881 is the DHT port if you wish to use it.
EXPOSE 49164 6881
# These volumes are mostly optional it depends on how you want to run your container.
VOLUME ["/data/complete", "/data/incomplete", "/data/watch", "/data/added", "/data/downloads", "/data/torrents"]
#ENTRYPOINT  ["rtorrent"]
CMD  ["rtorrent"]

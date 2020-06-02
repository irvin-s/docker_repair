
FROM ubuntu:latest

USER root
ENV IPFS_DIST_URL=https://dist.ipfs.io/go-ipfs/v0.4.10/go-ipfs_v0.4.10_linux-amd64.tar.gz \
    CADDY_DIST_URL=https://caddyserver.com/download/linux/amd64?plugins=http.cache,http.cors,http.ipfilter \
    IPFS_PATH=/data/ipfs \
    CADDYPATH=/data/caddy


RUN apt-get update ;\
apt-get dist-upgrade -y ;\
apt-get install -qy wget

RUN mkdir -p ~/tmp ;\
wget -qO- ${IPFS_DIST_URL} | tar xz -C ~/tmp/ ;\
mv ~/tmp/go-ipfs/ipfs /usr/local/bin/ ; rm -rf ~/tmp/*

RUN wget -qO- ${CADDY_DIST_URL} | tar xz -C ~/tmp/ ;\
mv ~/tmp/caddy /usr/local/bin/ ; rm -rf ~/tmp/*

RUN ipfs --version ; caddy --version 

COPY start /
EXPOSE 8080

# ENTRYPOINT /run
CMD /start
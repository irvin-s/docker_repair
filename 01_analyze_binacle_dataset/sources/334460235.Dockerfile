FROM phusion/baseimage:0.10.0

RUN   apt-add-repository -y ppa:bitcoin/bitcoin && \
        add-apt-repository ppa:gophers/archive && \
        echo 'deb http://ftp.debian.org/debian jessie-backports main' | tee /etc/apt/sources.list.d/jessie-backports.list && \
        apt-key adv --recv-key --keyserver hkp://keyserver.ubuntu.com:80 8B48AD6246925553 && \
        apt-get update && \
        apt-get install -y --no-install-recommends bitcoind && \
        apt-get install -y --no-install-recommends -t jessie-backports jq && \
        rm -rf /var/lib/apt/lists/*

COPY container-files /
# Expose mainnet ports (server, rpc)
EXPOSE 8333 8334

# Expose testnet ports (server, rpc)
EXPOSE 18333 18334

# 0MQ
EXPOSE 28332

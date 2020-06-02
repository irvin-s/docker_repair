FROM debian:latest

ENV HOME /home/dev

WORKDIR /home/dev/code/Nexus

VOLUME /home/dev/.Nexus

RUN apt-get update && apt-get -y --no-install-recommends install \
     build-essential \
     ca-certificates \
     git \
     libboost-all-dev \
     libdb-dev \
     libdb++-dev \
     libgmp3-dev \
     libminiupnpc-dev \
     libqrencode-dev \
     libqt4-dev \
     libssl-dev \
     psmisc \
     qt4-default \
     qt4-qmake \
     screen \
     vim \
     && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . /home/dev/code/Nexus

RUN cp makefile.unix Makefile && USE_LLD=1 make -j$(nproc) && rm -f Makefile

RUN qmake nexus-qt.pro "RELEASE=1" "USE_UPNP=-" "USE_LLD=1" && make -j$(nproc)

RUN cd qa/smoke && /bin/bash setup-two-local-test-nodes.sh

RUN cd /home/dev/code && git clone https://github.com/Nexusoft/PrimeSoloMiner.git && cd PrimeSoloMiner && ln -s makefile.unix Makefile && make -j$(nproc)

CMD /bin/bash qa/smoke/start-local-testnet.sh

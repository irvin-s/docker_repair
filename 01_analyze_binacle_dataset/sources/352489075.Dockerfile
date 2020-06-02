#docker run --rm -it \
       #-v ${HOME}/.config/keepassx:/root/.config/keepassx \ # Share Keepassx configuration folder, here it stores the location of the databases loaded
       #-v /tmp/.X11-unix:/tmp/.X11-unix \
       #-v ${HOME}/kdb:/home/gianarb/kdb \ # Share the location of your kee databases with the container
       #-e DISPLAY=unix$DISPLAY \
       #--rm \
       #--name keepassx \
       #gianarb/keepassx "$@"

FROM debian:sid
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

WORKDIR /tmp
RUN apt-get update && \
    apt-get install -y zlib1g-dev build-essential wget qt4-default libgcrypt20-dev cmake && \
    wget  https://www.keepassx.org/releases/2.0.3/keepassx-2.0.3.tar.gz && \
    tar xzvf keepassx-2.0.3.tar.gz && \
    cd keepassx-2.0.3 && \
    cmake . && make &&  make install && \
    rm -rf /var/lib/apt/lists/* /tmp/*


ENTRYPOINT ["/usr/local/bin/keepassx"]

FROM mitchtech/rpi-bladerf

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q  \
    apache2 \
    automake \
    ca-certificates \
    g++ \
    gcc \
    git \
    make \
    php5 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/evilsocket/evilbts.git && \
    cd evilbts/yate && \
    ./autogen.sh && \
    ./configure --prefix=/usr/local && \
    make -j4 && \
    make install && \
    ldconfig 

RUN cd /evilbts/yatebts && \
    ./autogen.sh && \
    ./configure --prefix=/usr/local && \
    make -j4 && \
    make install && \
    ldconfig && \
    ln -s /usr/local/share/yate/nib_web /var/www/html/nib && \
    chmod a+w -R /usr/local/etc/yate

EXPOSE 80

CMD ["yate -s"]

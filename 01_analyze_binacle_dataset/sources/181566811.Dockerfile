FROM ubuntu:trusty
MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

ENV VAGENT_USERNAME=admin
ENV VAGENT_SEVRET=admin

ENV VAGENT_USERNAME=admin
ENV VAGENT_SEVRET=admin

# Install base packages apache php imagemagick
RUN apt-get update --quiet > /dev/null && \
    apt-get install --assume-yes --force-yes -qq \
    curl apt-transport-https unzip make autoconf \
    libmicrohttpd-dev libcurl4-gnutls-dev python-docutils \
    autotools-dev automake1.9 libtool libncurses-dev \
    groff-base libpcre3-dev pkg-config && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

RUN curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add - && \
    echo "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.1" >> /etc/apt/sources.list.d/varnish-cache.list

RUN apt-get update --quiet > /dev/null && \
    apt-get install --assume-yes --force-yes -qq \
    varnish libvarnishapi-dev \ && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

RUN varnishd -V

ADD ./vagent2.zip /tmp/vagent2.zip
# RUN curl -o /tmp/vagent2.zip https://github.com/varnish/vagent2/archive/master.zip &&
RUN unzip -d /etc/ /tmp/vagent2.zip && \
    rm -rf /tmp/vagent2.zip

WORKDIR /etc/vagent2
RUN ./autogen.sh && \
    ./configure && \
    make clean && \
    make install

ADD ./bin/init.sh /init.sh
RUN chmod +x /init.sh

CMD ["/init.sh"]

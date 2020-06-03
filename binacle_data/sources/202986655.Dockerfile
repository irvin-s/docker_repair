FROM crux:3.1
MAINTAINER William Dizon <wdchromium@gmail.com>

RUN ports -u \
  && prt-get install -if python \
  && rm -rf /usr/ports/*

#enable prt-get repos
RUN mv /etc/ports/contrib.rsync.inactive /etc/ports/contrib.rsync \
  && sed -i 's/#prtdir \/usr\/ports\/contrib/prtdir \/usr\/ports\/contrib/' /etc/prt-get.conf

RUN ports -u \
  && prt-get install expat \
  git \
  librsync \
  rdiff-backup \
  screen \
  setuptools \
  meld3 \
  supervisor \
  icu \
  && rm -rf /usr/ports/*

#install node from source
RUN cd /root \
  && wget https://nodejs.org/dist/v4.4.0/node-v4.4.0.tar.gz \
  && tar -xf node-v4.4.0.tar.gz \
  && cd node-v4.4.0 \
  && ./configure --prefix=/usr --with-intl=system-icu --shared-openssl --shared-zlib --without-snapshot \
  && make && make install \
  && cd /root \
  && rm -rf /root/node-v4.4.0

#install chpassword utility
RUN cd /root \
  && httpup sync http://kyber.io/crux/ports/teatime/#chpasswd chpasswd \
  && cd /root/chpasswd \
  && pkgmk -d -i \
  && cd /root \
  && rm -rf /root/chpasswd

#download mineos from github
RUN mkdir -p /usr/games/minecraft \
  && cd /usr/games/minecraft \
  && git clone --depth=1 https://github.com/hexparrot/mineos-node.git . \
  && cp mineos.conf /etc/mineos.conf \
  && chmod +x webui.js mineos_console.js service.js \
  && npm install

#configure and run supervisor
RUN cp /usr/games/minecraft/init/supervisor_conf /etc/supervisor.d/mineos.conf
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

#entrypoint allowing for setting of mc password
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8443 25565-25570
VOLUME /var/games/minecraft

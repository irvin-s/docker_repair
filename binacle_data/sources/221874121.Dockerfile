FROM cwt114/alpine-ssh
MAINTAINER Barra <bxt@mondedie.fr>

RUN echo "@commuedge http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk -U add p7zip \
 && echo "root:QNLzGHtDa1j2" | chpasswd

COPY startup /usr/local/bin/startup
COPY supervisord.conf /etc/supervisor/supervisord.conf

RUN chmod +x /usr/local/bin/startup

VOLUME [ \
    "/root/torrents" \
 ]

CMD ["/sbin/tini","--","startup"]

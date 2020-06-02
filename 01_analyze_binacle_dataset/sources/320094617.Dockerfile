FROM cwt114/alpine-ssh
MAINTAINER Barra <bxt@mondedie.fr>

RUN echo "@commuedge http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk -U add \
    cdrkit@commuedge \
    tini@commuedge \
    supervisor \
 && echo "root:QNLzGHtDa1j2" | chpasswd


VOLUME [ \
    "/root/torrents" \
]

COPY startup /usr/local/bin/startup
COPY supervisord.conf /etc/supervisor/supervisord.conf

RUN chmod +x /usr/local/bin/startup

CMD ["/sbin/tini","--","startup"]

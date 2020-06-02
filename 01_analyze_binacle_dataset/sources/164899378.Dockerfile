FROM progrium/busybox
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

RUN opkg-install base-files bash
RUN opkg-install curl lighttpd

#ADD index.html /www/index.html
#ADD lighttpd.conf /etc/lighttpd/lighttpd.conf
ONBUILD slidefire.tar.gz /www

CMD ["lighttpd", "-D","-f", "/etc/lighttpd/lighttpd.conf"]

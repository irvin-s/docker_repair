FROM alpine

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing/ >> /etc/apk/repositories &&\
    apk add --no-cache proftpd proftpd-utils proftpd-mod_auth_file

RUN mkdir -pv /run/proftpd/ &&\
    mkdir -pv /ftp &&\
    echo pass | ftpasswd --file /etc/ftpd.passwd --passwd --name test --uid 0 -gid 0 --home /ftp --shell /bin/sh --stdin &&\
    ftpasswd --file /etc/ftpd.group --group --name test --gid 0

ADD ./proftpd.conf /etc/proftpd/proftpd.conf

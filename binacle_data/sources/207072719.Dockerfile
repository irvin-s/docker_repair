FROM alpine:3.6

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV FTPUSER=ftpuser \
    FTPPASS=ftppass

COPY vsftpd* /tmp/

RUN apk add --update-cache \
        build-base \
        linux-pam-dev \
        curl \
        openssl \
        ncftp \
        vsftpd && \
    mv /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.orig && \
    mv /tmp/vsftpd.conf /etc/vsftpd && \
    mv /tmp/vsftpd /etc/pam.d && \
    mv /tmp/vsftpd.sh / && \
    chmod +x /vsftpd.sh && \
    mkdir /pwdfile && \
    cd /pwdfile && \
    curl -sSL https://github.com/tiwe-de/libpam-pwdfile/archive/v1.0.tar.gz | tar xz --strip 1 && \
    make install && \
    cd / && \
    rm -rf /pwdfile && \
    apk del \
        build-base \
        linux-pam-dev \
        curl && \
    rm -rf /var/cache/apk/*

VOLUME /var/lib/ftp
WORKDIR /var/lib/ftp

EXPOSE 21

CMD ["/vsftpd.sh"]

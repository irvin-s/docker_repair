FROM alpine:3.7

RUN apk add --no-cache vsftpd

ENV FTP_USER=ftpuser \
    FTP_PASS=ftppasswd

COPY entrypoint.sh /usr/sbin/

EXPOSE 20 21 10090-10100

CMD /usr/sbin/entrypoint.sh
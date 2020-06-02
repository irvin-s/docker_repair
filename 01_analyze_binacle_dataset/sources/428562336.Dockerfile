FROM debian:jessie

RUN apt-get update && apt-get install -y -q vsftpd

ADD vsftpd.conf /etc/
ADD vsftpd.sh /root/

RUN mkdir -p /var/run/vsftpd/empty \
 && chmod +x /root/vsftpd.sh \
 && chown root:root /etc/vsftpd.conf

VOLUME /ftp/


EXPOSE 21/tcp

ENTRYPOINT ["/root/vsftpd.sh"]
CMD ["vsftpd"]

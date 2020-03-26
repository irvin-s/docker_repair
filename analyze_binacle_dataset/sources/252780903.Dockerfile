FROM alpine:3.3  
MAINTAINER Jérémy SEBAN <jeremy@seban.eu>  
  
RUN apk add --update ngircd && rm -rf /var/cache/apk  
COPY ./ngircd.conf /etc/ngircd.conf.orig  
COPY ./entrypoint.sh /bin/entrypoint  
RUN chmod +x /bin/entrypoint  
  
VOLUME ["/etc/ngircd"]  
  
ENTRYPOINT ["/bin/entrypoint"]  
  
CMD ["/usr/sbin/ngircd", "--nodaemon", "--passive"]


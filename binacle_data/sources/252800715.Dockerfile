FROM alpine:3.7  
MAINTAINER Alexey Kovrizhkin <lekovr+dopos@gmail.com>  
  
ENV DOCKERFILE_VERSION 171231  
# pdns-doc gives /usr/share/doc/pdns/schema.pgsql.sql  
RUN apk --update add pdns-backend-pgsql pdns-backend-bind pdns-doc  
  
# Comment windows-only key  
RUN sed -i 's/^use-logfile=\\(.*\\)/# use-logfile=\1/' /etc/pdns/pdns.conf  
RUN sed -i 's/^wildcards=\\(.*\\)/# wildcards=\1/' /etc/pdns/pdns.conf  
  
EXPOSE 53/udp 53/tcp 8081  
CMD ["/usr/sbin/pdns_server", "--master", "--daemon=no"]  
  


FROM alpine:latest  
LABEL maintainer "AMSSN <info@amssn.eu>"  
  
ENV BIND_USER=named  
  
RUN apk add --no-cache bash bind bind-tools tzdata && rm -r /etc/bind/*  
ADD bind-data /etc/bind/  
RUN rndc-confgen -a && chown -cR named:named /etc/bind  
VOLUME ["/etc/bind"]  
  
ADD entrypoint.sh /sbin/entrypoint.sh  
RUN chmod 755 /sbin/entrypoint.sh  
  
EXPOSE 53/udp 53/tcp 953/tcp 8053/tcp  
  
WORKDIR /etc/bind  
  
ENTRYPOINT ["/sbin/entrypoint.sh"]  
CMD ["/usr/sbin/named"]  


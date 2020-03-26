FROM alpine  
  
RUN apk --no-cache add bind && \  
mkdir -p /var/bind/log  
  
COPY bind /etc/bind/  
  
EXPOSE 53/udp  
  
CMD /usr/sbin/named -f -c /etc/bind/named.conf


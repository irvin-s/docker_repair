FROM alpine  
MAINTAINER Simone Esposito <chaufnet@gmail.com>  
  
COPY docker-entrypoint.sh /  
  
RUN apk add --no-cache openssh openssh-sftp-server dropbear \  
&& rm -rf /var/cache/apk/* \  
&& mkdir /etc/dropbear \  
&& touch /var/log/lastlog \  
&& chmod +x /docker-entrypoint.sh  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
CMD ["dropbear", "-RFEmwg", "-p", "22"]  
  


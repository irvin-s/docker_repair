FROM ubuntu:14.04  
MAINTAINER ONO Admin <admin@zh71.net>  
  
RUN apt-get update  
RUN apt-get install -y stunnel  
  
COPY stunnel.conf /etc/stunnel/stunnel.conf  
RUN sed -i 's/^ENABLED=0/ENABLED=1/' /etc/default/stunnel4  
  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
  
EXPOSE 3128  
CMD ["/entrypoint.sh"]  


FROM debian:jessie  
MAINTAINER deva@brispark <deva@brispark.com>  
  
ENV APP smb  
ENV VERSION 6  
ENV _HOME_ /home/app  
ENV FWATCH ${_HOME_}/smb.conf  
ENV DEBIAN_FRONTEND noninteractive  
  
EXPOSE 137/udp 138/udp 139 445  
ADD app /app  
ADD root /root  
RUN /app/bin/install.sh  
  
ENTRYPOINT ["/app/entry.sh"]  
CMD ["start"]  


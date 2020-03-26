FROM debian:jessie  
MAINTAINER deva@brispark <deva@brispark.com>  
  
ENV APP munin  
ENV VERSION 4  
ENV DEBIAN_FRONTEND noninteractive  
  
EXPOSE 80/tcp  
  
ADD app /app  
RUN /app/bin/install.sh  
  
ENTRYPOINT ["/app/entry.sh"]  
CMD ["start"]  


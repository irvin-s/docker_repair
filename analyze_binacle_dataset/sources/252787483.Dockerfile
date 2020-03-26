FROM debian:jessie  
MAINTAINER deva@brispark <deva@brispark.com>  
  
ENV APP postfix  
ENV VERSION 6  
ENV DEBIAN_FRONTEND noninteractive  
  
EXPOSE 25  
ADD app /app  
RUN /app/bin/install.sh  
  
ENTRYPOINT ["/app/entry.sh"]  
CMD ["start"]  


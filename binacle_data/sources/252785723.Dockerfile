  
FROM debian:jessie  
MAINTAINER Compass Ventures  
  
RUN apt-get update -qq -y && \  
apt-get install -qq -y socat && \  
apt-get clean  
  
ADD start-socat.sh start-socat.sh  
  
RUN chmod 755 /*.sh  
  
CMD ["/start-socat.sh"]  
  
# expose ports manually because ECS doesn't allow expose command yet...  
EXPOSE 6379  
EXPOSE 27017  
EXPOSE 8080  
EXPOSE 3000


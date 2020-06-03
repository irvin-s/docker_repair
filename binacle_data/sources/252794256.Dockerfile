FROM node:latest  
  
MAINTAINER Armagan Amcalar "armagan@amcalar.com"  
EXPOSE 80  
EXPOSE 443  
EXPOSE 43554  
VOLUME ["/app"]  
ADD start.sh /start.sh  
  
RUN apt-get update  
RUN apt-get upgrade -y  
RUN apt-get install -y net-tools  
  
RUN wget -qO- http://install.keymetrics.io/install.sh | bash  
RUN pm2 install pm2-server-monit  
RUN chmod 755 /start.sh  
  
CMD ["/start.sh"]  


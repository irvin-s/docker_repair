FROM bepsoccer/all-in-one-hackazon:proxied  
MAINTAINER Brad Parker <brad@parker1723.com>  
  
# setup node  
COPY ./nodejs /var/express  
WORKDIR /var/express  
RUN npm install --production  
  
EXPOSE 8080  
CMD ["/bin/bash", "/start.sh"]


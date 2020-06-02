FROM iojs:latest  
MAINTAINER Akeem McLennon <akeem@mclennon.com>  
RUN mkdir -p /var/www/my-app  
RUN npm install -g ember-cli bower phantomjs  
CMD ["ember"]  
VOLUME ["/usr/src/app"]  
WORKDIR /usr/src/app  
EXPOSE 4200 4200  


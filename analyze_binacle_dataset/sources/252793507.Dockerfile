FROM node:7.2.1-alpine  
  
MAINTAINER danthegoodman  
EXPOSE 80 443  
RUN apk --no-cache add openssl  
  
WORKDIR /opt  
ADD make-cert.sh /opt  
RUN sh make-cert.sh  
  
ADD server.js /opt  
CMD node server.js


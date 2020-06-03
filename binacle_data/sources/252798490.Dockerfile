FROM alpine  
MAINTAINER dentych  
  
RUN apk update && \  
apk add --no-cache \  
nodejs && \  
mkdir /nodeapp  
  
WORKDIR /nodeapp  
  
ADD start.sh /start.sh  
  
CMD ["../start.sh"]  


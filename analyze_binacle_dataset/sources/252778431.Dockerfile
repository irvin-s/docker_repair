FROM node:4.2.1-slim  
MAINTAINER Dylan Arbour <dylan.arbour@gmail.com>  
  
ENV PORT="9000"  
ENV PRIVATE="false"  
RUN npm install -g shout && \  
mkdir /shout  
  
VOLUME /shout  
WORKDIR /shout  
  
ADD init.sh /init.sh  
RUN chmod u+x /init.sh  
  
EXPOSE 9000  
ENTRYPOINT ["/bin/bash", "-c", "/init.sh"]  


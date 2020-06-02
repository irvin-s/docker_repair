FROM mhart/alpine-node:8  
# inspired by https://github.com/MehrCurry/docker-iobroker  
MAINTAINER André Wolski <andre@dena-design.de>  
  
RUN apk add --no-cache bash python build-base  
  
RUN mkdir -p /opt/iobroker/  
WORKDIR /opt/iobroker/  
RUN npm install iobroker --unsafe-perm && echo $(hostname) > .install_host  
ADD scripts/run.sh run.sh  
RUN chmod +x run.sh  
VOLUME /opt/iobroker/  
  
EXPOSE 8081  
CMD /opt/iobroker/run.sh  


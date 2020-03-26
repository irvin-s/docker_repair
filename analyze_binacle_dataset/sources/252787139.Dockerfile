FROM node:6-alpine  
  
MAINTAINER "Braydee Johnson" <braydee@braydeejohnson.com>  
  
RUN apk --update add \  
python \  
make \  
g++ \  
&& rm -rf /var/cache/apk/* \  
&& npm install -g screeps@2.5.X \  
&& adduser -S -g 'Screeps Private Server' -h '/screeps' screeps-server  
  
COPY entrypoint.sh /usr/local/bin/  
  
#Volumes  
VOLUME ["/screeps"]  
WORKDIR /screeps  
USER screeps-server  
  
#Ports  
EXPOSE 21025  
EXPOSE 21026  
ENTRYPOINT ["entrypoint.sh"]  
  
CMD ["screeps", "start"]


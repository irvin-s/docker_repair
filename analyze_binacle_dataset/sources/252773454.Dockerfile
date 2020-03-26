# node 9.11.1  
FROM node:9.11.1-alpine  
MAINTAINER Jonathan Rosenbaum <fspc@freesoftwarepc.com>  
  
ENV ETHERPAD_VERSION 1.6.6  
RUN apk update; apk add bash curl gzip unzip mysql-client  
  
WORKDIR /opt/  
  
RUN curl -SL \  
https://github.com/ether/etherpad-lite/archive/${ETHERPAD_VERSION}.zip \  
> etherpad.zip && unzip etherpad && rm etherpad.zip && \  
mv etherpad-lite-${ETHERPAD_VERSION} etherpad-lite  
  
WORKDIR etherpad-lite  
  
RUN bin/installDeps.sh && rm settings.json  
COPY entrypoint.sh /entrypoint.sh  
  
RUN sed -i 's/^node/exec\ node/' bin/run.sh  
RUN sed -i 's/^bin/##bin/' bin/run.sh  
  
VOLUME /opt/etherpad-lite/var /opt/etherpad-lite/node_modules  
RUN ln -s var/settings.json settings.json  
  
EXPOSE 9001  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["bin/run.sh", "--root"]  


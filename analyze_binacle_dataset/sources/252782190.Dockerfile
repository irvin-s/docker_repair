FROM node:5.9.1-slim  
MAINTAINER Danny Gershman <dannyg@beaconlive.com>  
RUN cd /opt \  
&& apt-get update \  
&& apt-get install -y git \  
&& git clone https://github.com/cinchcast/sinopia.git \  
&& cd sinopia \  
&& mkdir storage \  
&& npm install \  
&& adduser --disabled-password --gecos "" sinopia \  
&& chown -R sinopia: /opt/sinopia  
  
USER sinopia  
EXPOSE 4873  
WORKDIR /opt/sinopia  
CMD node bin/sinopia --config conf/default.yaml  


FROM ubuntu:latest  
MAINTAINER Quentin Peten <q.peten@students.ephec.be>  
  
#Install asterisk  
RUN set -x \  
&& apt-get update \  
&& apt-get upgrade -y \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y asterisk \  
&& rm -rf /var/lib/apt/lists/*  
  
EXPOSE 5060/tcp  
EXPOSE 5060/udp  
  
CMD /usr/sbin/asterisk -vgf  


FROM openhab/openhab:2.2.0-amd64-debian  
MAINTAINER Dmytro Studynskyi <dimitrystd@gmail.com>  
  
RUN apt-get -y update \  
&& apt-get -y install \  
# orvibo script  
python3 \  
# network binding  
arping iputils-ping \  
# pushbullet script  
curl \  
&& apt-get autoclean \  
&& apt-get --purge -y autoremove \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN chmod u+s /usr/sbin/arping  


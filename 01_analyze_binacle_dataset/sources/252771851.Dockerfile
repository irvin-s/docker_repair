FROM ubuntu:xenial  
  
MAINTAINER atomney <atomney+docker@gmail.com>  
  
# Starting steam with validate is slow, lets make it an option  
ENV CHECKFILES "false"  
# Variable to enable RCON, enabled by default  
ENV RCON "true"  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update \  
&& apt-get -y install lib32gcc1 wget \  
&& rm -rf /var/lib/apt/lists/* \  
&& apt-get clean \  
&& mkdir -p /data/ark/backup \  
&& useradd -d /data/ark -s /bin/bash --uid 1000 ark \  
&& chown -R ark: /data/ark  
  
EXPOSE 27015/udp 7778/udp  
EXPOSE 32330/tcp  
  
ADD start.sh /usr/local/bin/start  
  
USER ark  
VOLUME /data/ark  
WORKDIR /data/ark  
CMD ["start"]  


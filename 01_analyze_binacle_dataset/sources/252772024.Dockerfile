# Copyright 2015 Sean Nelson <audiohacked@gmail.com>  
FROM debian:jessie  
MAINTAINER Sean Nelson <audiohacked@gmail.com>  
  
ENV BASE_URL=http://media.steampowered.com/installer/steamcmd_linux.tar.gz  
ENV PATH /steamcmd:$PATH  
  
WORKDIR /steamcmd  
  
USER root  
RUN apt-get update && apt-get install -y --no-install-recommends \  
ca-certificates \  
curl \  
lib32stdc++6 \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* \  
&& groupadd -r steam \  
&& useradd -r -m -g steam steam \  
&& curl -SL $BASE_URL | tar -xzC /steamcmd \  
&& chmod u+x steamcmd.sh \  
&& chown -R steam:steam /steamcmd  
  
USER steam  
RUN ["steamcmd.sh", "+exit"]  
CMD ["bash"]  
  


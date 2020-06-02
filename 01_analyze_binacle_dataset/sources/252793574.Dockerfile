FROM debian:9.2  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get -yq install \  
calibre \  
curl \  
jq \  
python \  
wget \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN mkdir /anthology /data \  
&& touch /data/.nogood  
  
COPY . /anthology  
  
VOLUME ["/data"]  
WORKDIR /data  
  
ENTRYPOINT ["/anthology/docker-entrypoint.sh"]  


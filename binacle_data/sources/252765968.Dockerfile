FROM debian:jessie  
  
RUN apt-get update && apt-get install -y \  
curl \  
&& curl -sL https://deb.nodesource.com/setup_6.x | bash /dev/stdin \  
&& apt-get install -y nodejs git-all  
  
RUN cd /srv \  
&& npm install phenomic \  
&& npm install  
  
ENV LC_ALL=C.UTF-8 \  
LANG=en_US.UTF-8 \  
LANGUAGE=en_US.UTF-8  
WORKDIR /srv  
VOLUME /srv  
  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  


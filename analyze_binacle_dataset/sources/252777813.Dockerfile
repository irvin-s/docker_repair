FROM ubuntu:latest  
MAINTAINER Andreas Oeldemann <hey@aoel.io>  
  
RUN apt-get update \  
&& apt-get install -y qrencode zbar-tools \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY init.sh /  
  
VOLUME ["/data"]  
  
ENTRYPOINT ["/init.sh"]  


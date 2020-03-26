FROM debian:jessie  
LABEL maintainer "Benjamin Stein <info@diffus.org>"  
RUN apt-get update \  
&& apt-get -y install nyancat \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
CMD ["/usr/bin/nyancat"]  


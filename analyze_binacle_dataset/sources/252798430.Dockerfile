FROM debian:jessie  
MAINTAINER dennis@moellegaard.dk  
  
ENV DEBIAN_FRONTEND noninteractive  
  
ENV LANG en_US.UTF-8  
ENV LC_ALL C.UTF-8  
ENV LANGUAGE en_US.UTF-8  
RUN apt-get update && \  
apt-get dist-upgrade -y && \  
apt-get -qy --no-install-recommends install ruby opendkim-tools postfix && \  
rm -rf /var/lib/apt/lists/*  
  
COPY assets/ /  
  
VOLUME /config  
  
CMD ["/usr/bin/ruby", "/root/generator.rb", "/config"]  
  


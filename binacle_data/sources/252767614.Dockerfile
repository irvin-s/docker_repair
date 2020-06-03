FROM ubuntu:14.04  
MAINTAINER Maksym Nebot <maksym.nebot@accenture.com>  
  
RUN apt-get update && \  
apt-get -y install git && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
RUN git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt  
RUN /opt/letsencrypt/letsencrypt-auto certonly --help  
  
expose 80 443  
ENTRYPOINT ["/opt/letsencrypt/letsencrypt-auto"]  


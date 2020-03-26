FROM debian:8  
MAINTAINER Marcel Sinn <loopyargon@gmail.com>  
  
RUN \  
apt-get update && \  
apt-get install -y \  
linkchecker &&\  
rm -rf /var/lib/apt/lists/*  
  
ENTRYPOINT ["/usr/bin/linkchecker"]  
CMD ["--help"]  


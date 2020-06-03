FROM ubuntu:artful  
MAINTAINER Jethro Van Thuyne <post@jethro.be>  
  
RUN apt-get update && \  
apt-get install -y hledger && \  
apt-get autoremove && \  
apt-get autoclean && \  
rm -rf /var/lib/apt/lists  
  
VOLUME ["/data"]  
ENTRYPOINT ["hledger"]  
CMD ["--help"]  


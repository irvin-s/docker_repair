############################################  
# director v0.1  
# author: Hervé Beraud  
# url: https://github.com/4383/director  
############################################  
FROM ubuntu:latest  
RUN \  
apt-get update && \  
apt-get -y upgrade  
  
RUN \  
apt-get -y install tor && \  
apt-get -y install proxychains && \  
apt-get -y install polipo  
  
RUN \  
apt-get -y install nmap  
  
ENV TARGET=127.0.0.1  
  
CMD \  
service tor start && \  
service polipo start && \  
nmap -A -T4 $TARGET  
#proxychains nmap -A -T4 $TARGET  


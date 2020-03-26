FROM debian:stable-slim  
  
ENV LANG C.UTF-8  
ENV LC_ALL C.UTF-8  
RUN apt-get update -y &&\  
apt-get install curl -y &&\  
curl -LO https://nzbget.net/download/nzbget-latest-bin-linux.run &&\  
mkdir /opt/nzbget &&\  
sh nzbget-latest-bin-linux.run --destdir /opt/nzbget &&\  
rm nzbget-latest-bin-linux.run &&\  
apt-get clean &&\  
rm -rf \  
/tmp/* \  
/var/lib/apt/lists/* \  
/var/tmp/*  
  
EXPOSE 6789  
VOLUME /TV /Movies /completed /download  
  
WORKDIR /opt/nzbget  
  
CMD ["./nzbget","-s","-o","OutputMode=log"]


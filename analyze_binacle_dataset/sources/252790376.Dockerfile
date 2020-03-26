FROM debian:stable-slim  
  
RUN apt-get update -y &&\  
apt-get install git-core python -y &&\  
mkdir /opt/couchpotato &&\  
cd /opt/couchpotato &&\  
git clone https://github.com/CouchPotato/CouchPotatoServer.git &&\  
apt-get clean &&\  
rm -rf \  
/tmp/* \  
/var/lib/apt/lists/* \  
/var/tmp/*  
  
VOLUME /Movies /completed /download  
  
EXPOSE 5050  
WORKDIR /opt/couchpotato  
  
CMD ["python","CouchPotatoServer/CouchPotato.py"]


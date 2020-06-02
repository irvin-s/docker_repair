FROM debian:stable-slim  
  
ENV LANG C.UTF-8  
ENV LC_ALL C.UTF-8  
RUN apt-get update -y &&\  
apt-get install -y \  
git-core \  
python &&\  
git clone https://github.com/JonnyWong16/plexpy.git &&\  
apt-get clean &&\  
rm -rf \  
/tmp/* \  
/var/lib/apt/lists/* \  
/var/tmp/*  
  
WORKDIR plexpy  
  
VOLUME /TV /Movies  
  
EXPOSE 8181  
CMD ["python","PlexPy.py","--datadir=/data","--config=/data/config.ini"]


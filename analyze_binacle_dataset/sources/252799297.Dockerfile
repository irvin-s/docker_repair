FROM ubuntu:xenial  
MAINTAINER dfabian  
  
RUN \  
apt-get update && \  
DEBIAN_FRONTEND=nointeractive \  
apt-get -y install \  
ices2 \  
vorbis-tools \  
&& \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
ADD ./etc /etc  
ADD ./configIces.sh /usr/local/bin/configIces.sh  
  
RUN \  
mkdir -pv /home/music \  
/var/log/ices \  
&& \  
touch /home/music/playlist.txt && \  
ln -sf /dev/stdout /var/log/ices/ices.log  
  
RUN chmod u+x /usr/local/bin/configIces.sh  
  
ENTRYPOINT ["/usr/local/bin/configIces.sh"]  


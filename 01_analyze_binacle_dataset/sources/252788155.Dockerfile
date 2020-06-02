FROM debian:unstable  
  
MAINTAINER Alexander Sosna <alexander.sosna@credativ.de>  
  
RUN \  
apt-get update && \  
apt-get -y install \  
debhelper \  
build-essential \  
devscripts \  
fakeroot \  
git \  
git-buildpackage \  
pristine-tar  
  
CMD ["bash"]  


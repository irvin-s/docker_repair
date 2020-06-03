FROM debian  
  
MAINTAINER Alexander Sosna <alexander.sosna@credativ.de>  
  
RUN \  
apt-get update && \  
apt-get -y install \  
git \  
rsync \  
openssh-client  
  
CMD ["bash"]  


FROM anhem/docker-ubuntu-openjdk8-git-maven  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && \  
apt-get install -y sudo ecryptfs-utils mhddfs samba samba-common-bin && \  
apt-get clean  
  
ENV DEBIAN_FRONTEND ""  


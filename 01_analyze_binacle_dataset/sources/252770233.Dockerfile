FROM oixhwotl/arches3-v1:15.10  
MAINTAINER ASCDC <ascdc@gmail.com>  
  
ADD run.sh /run.sh  
  
RUN DEBIAN_FRONTEND=noninteractive && \  
chmod +x /*.sh && \  
apt-get update && \  
apt-get -y dist-upgrade  
  
WORKDIR /root/my_hip_app  
ENTRYPOINT ["/run.sh"]  


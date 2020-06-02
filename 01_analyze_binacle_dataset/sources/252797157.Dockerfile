# Requires --net=host --privileged  
FROM ubuntu:14.04  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && apt-get -y install curl bash grep sed iptables  
ADD fw.sh /opt/fw.sh  
ENTRYPOINT ["/opt/fw.sh"]  


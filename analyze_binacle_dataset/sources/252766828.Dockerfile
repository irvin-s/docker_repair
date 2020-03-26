FROM ubuntu:trusty  
  
MAINTAINER Alan Quach <integsrtite@gmail.com>  
  
ENV TZ=America/Los_Angeles  
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  
RUN locale-gen en_US.UTF-8  
  
# CORE  
RUN apt-get update && apt-get install -y curl \  
libnss3-tools \  
xdg-utils  
  
CMD ["/bin/bash"]  
  


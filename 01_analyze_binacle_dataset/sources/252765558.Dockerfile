FROM liuchong/rustup:all3  
  
MAINTAINER Yann Leretaille <y.leretaille@1aim.com>  
  
WORKDIR /root  
  
RUN apt-get update  
  
# common tools required in automated runners  
RUN apt-get install --no-install-recommends -y \  
openssh-client gawk rsync libz-dev  
  
#clear apt cache  
RUN rm -rf /var/lib/apt/lists/*  


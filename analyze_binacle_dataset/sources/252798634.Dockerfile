FROM debian:latest  
  
RUN apt-get update \  
&& apt-get install -y openssh-client git-core rsync  
  
RUN mkdir -p ~/.ssh  
  
ENTRYPOINT /bin/bash  


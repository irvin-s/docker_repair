FROM ubuntu:latest  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN set -e \  
&& ln -sf /bin/bash /bin/sh  
  
RUN set -e \  
&& apt-get -y update \  
&& apt-get -y dist-upgrade \  
&& apt-get -y install curl git ssh-client \  
&& apt-get -y autoremove \  
&& apt-get clean  
  
ENTRYPOINT ["/bin/bash", "-c"]  


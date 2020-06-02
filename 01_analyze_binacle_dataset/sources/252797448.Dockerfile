FROM ubuntu:14.04.3  
  
ENV UNISON_VERSION 2.40.102-2ubuntu1  
  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive \  
apt-get install -y unison=$UNISON_VERSION && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ENTRYPOINT ["unison"]  


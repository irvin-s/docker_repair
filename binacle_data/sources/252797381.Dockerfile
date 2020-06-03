# container-agent Dockerfile  
FROM clusterhq/flocker-core:1.14.0  
MAINTAINER Madhuri Yechuri <madhuri.yechuri@clusterhq.com>  
  
ENV FLOCKER_VERSION 1.14.0-1  
RUN sudo apt-get update && sudo apt-get -y --force-yes install \  
clusterhq-flocker-docker-plugin=${FLOCKER_VERSION}  
  
CMD ["/usr/sbin/flocker-docker-plugin"]  


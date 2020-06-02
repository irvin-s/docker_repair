FROM conyac/base:ubuntu20170517.1  
#ARG NODE_VERSION=6.6.0  
ARG NODE_VERSION=4.8.4  
ENV NODE_VERSION=${NODE_VERSION}  
  
ADD build.sh /tmp/node_base_build.sh  
RUN bash -x /tmp/node_base_build.sh  
  


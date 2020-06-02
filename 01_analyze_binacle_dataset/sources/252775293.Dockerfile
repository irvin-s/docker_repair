FROM beevelop/nodejs-python  
MAINTAINER Maik Hummel <yo@beevelop.com>  
  
ENV CORCI_PROTOCOL http  
  
RUN apt-get update -qq && \  
apt-get install -y git && \  
npm i -g beevelop/corci-master  
  
CMD corci-master -h 0.0.0.0 -p 8080 -q ${CORCI_PROTOCOL} -l /builds  
  
VOLUME ["/data", "/builds"]  
WORKDIR /data  
  
EXPOSE 8080  


FROM ubuntu:14.04  
MAINTAINER Anthony Howe  
  
RUN apt-get update && apt-get install -y cifs-utils  
  
COPY start /opt/start/.  
  
WORKDIR /opt/start  
  
ENTRYPOINT ["/bin/bash", "/opt/start/generate-random-files.sh"]  


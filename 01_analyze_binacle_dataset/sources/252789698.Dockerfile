FROM debian:squeeze  
COPY sources.list /etc/apt  
COPY 90ignore-release-date /etc/apt/apt.conf.d  
RUN apt-get update && apt-get install -y \  
\--no-install-recommends \  
build-essential \  
devscripts \  
equivs  


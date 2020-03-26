FROM google/cloud-sdk  
LABEL MAINTAINER="Aaron Trout <aaron@trouter.co.uk>"  
RUN apt-get update && \  
apt-get install -y git python3 python3-pip && \  
rm -rf /var/lib/apt/lists && \  
pip3 install click jinja2  
  
ENV LC_ALL=C.UTF-8  
ENV LANG=C.UTF-8  


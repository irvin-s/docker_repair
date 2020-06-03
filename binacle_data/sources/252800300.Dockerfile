FROM ubuntu  
RUN apt-get update && \  
apt-get install -y python2.7 && apt-get install -y python-pip && \  
pip install bottle  
  


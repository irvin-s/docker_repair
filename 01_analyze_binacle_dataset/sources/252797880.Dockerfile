FROM ubuntu:14.04  
RUN apt-get update && \  
apt-get install -y python python-pip python-dev  
  
RUN pip install python-keyczar  
  
ADD ./files /files  
  
ENTRYPOINT ["/files/generate_keys.sh"]  


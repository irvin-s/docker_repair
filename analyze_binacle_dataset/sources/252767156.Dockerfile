FROM debian:jessie  
  
RUN apt-get update && apt-get install -y python python-pip python-dev  
RUN pip install 'ansible>=1.9,<2.0'  
  
LABEL name="ansible"  
LABEL usage="automation"  
  
CMD bash  


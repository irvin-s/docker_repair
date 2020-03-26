FROM debian:jessie  
  
MAINTAINER Adam Alexander <adamalex@gmail.com>  
  
RUN apt-get update && apt-get install -y python python-setuptools python-pip  
RUN pip install python-troveclient  
  
ENTRYPOINT ["/usr/local/bin/trove"]  


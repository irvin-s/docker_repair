FROM ubuntu:16.04  
RUN apt-get update  
RUN apt-get install -y osmctools  
RUN apt-get install -y python3  
  
ADD convert.py /scripts/convert.py  
  
WORKDIR /data  
  
ENTRYPOINT ["python3", "/scripts/convert.py"]


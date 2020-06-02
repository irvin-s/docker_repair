FROM python:2-alpine  
  
RUN pip install elasticsearch-curator  
  
ADD curator.yml /root/curator.yml  
ADD config.yml /root/config.yml  
  
ENTRYPOINT ["curator", "--config", "/root/config.yml", "/root/curator.yml"]  


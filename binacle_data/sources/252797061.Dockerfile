FROM debian:wheezy  
  
  
RUN (apt-get update && apt-get install -y python python-flask)  
COPY . /opt/cloudfleet/app  
WORKDIR /opt/cloudfleet/app  
  
CMD python -u wellknown.py  
  
EXPOSE 80  


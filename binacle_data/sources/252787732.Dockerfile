FROM frolvlad/alpine-python3  
  
MAINTAINER Virgil Chereches <virgil.chereches@gmx.net>  
  
RUN pip install urllib3  
  
COPY prom-rancher-sd.py /  
RUN chmod +x /prom-rancher-sd.py  
  
VOLUME /prom-rancher-sd-data  
  
CMD ["/prom-rancher-sd.py"]  


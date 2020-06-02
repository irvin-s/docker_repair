FROM frolvlad/alpine-python3  
  
RUN pip install urllib3  
  
COPY federation-prom-rancher-sd.py /  
RUN chmod +x /federation-prom-rancher-sd.py  
  
VOLUME /federation-prom-rancher-sd-data  
  
WORKDIR /federation-prom-rancher-sd-data  
  
CMD ["/federation-prom-rancher-sd.py"]  


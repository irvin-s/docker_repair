FROM fedora:22  
RUN dnf install -y python-pip --setopt=tsflags=nodocs && \  
pip install paho-mqtt  
  
ADD mqtt-client.py /  
RUN chmod 750 /mqtt-client.py  
  
ENTRYPOINT /mqtt-client.py  


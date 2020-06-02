FROM python:2.7-slim  
  
ADD requirements.txt /usr/src/app/  
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt  
ADD ssl-ping.py cacert.pem /usr/src/app/  
ENTRYPOINT ["/usr/src/app/ssl-ping.py"]  


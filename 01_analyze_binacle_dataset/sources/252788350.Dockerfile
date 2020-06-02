FROM elyase/staticpython  
MAINTAINER Christian Rohling <crohling88@gmail.com>  
  
ENV SMTP_USERNAME="" \  
SMTP_PASSWORD="" \  
FROM_ADDR="" \  
TO_ADDR="" \  
CONNECTION_HOSTS="" \  
SMTP_SERVER="smtp.gmail.com:587" \  
SUBJECT_LINE="Connection error for %s:%s"  
COPY . /opt/monitor  
  
ENTRYPOINT ["/opt/monitor/run.py"]  


FROM python:3.6  
MAINTAINER Benedikt Lang <mail@blang.io>  
  
COPY sphinx-setup/ /data/  
RUN pip install -r /data/requirements.txt  
CMD ["/data/docs.sh"]  
VOLUME ["/data/input", "/data/output"]  


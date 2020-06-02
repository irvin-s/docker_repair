FROM python:latest  
MAINTAINER Jean-Baptiste Dusseaut <jbdusseaut@arpinum.fr>  
RUN pip install mongo-connector elastic2-doc-manager  
COPY scripts /data  
WORKDIR /data  
CMD bash /data/run.sh  


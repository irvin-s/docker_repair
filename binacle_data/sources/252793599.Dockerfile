FROM ubuntu:latest  
RUN mkdir /data  
COPY beavis.txt /data/  
ENTRYPOINT ["cat", "/data/beavis.txt"]  


FROM ubuntu:14.04  
RUN apt-get update  
RUN apt-get install -y vim  
RUN apt-get install -y wget  
RUN mkdir /data/myvol -p  
RUN echo "creating a directory" > /data/myvol/test  
EXPOSE 80 8080  
VOLUME /data/myvol  


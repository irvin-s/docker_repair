FROM debian:latest  
MAINTAINER Brie Carranza <hi@brie.ninja>  
RUN apt-get update && apt-get install -y \  
python3-numpy \  
python3-scipy \  
&& rm -rf /var/lib/apt/lists/*  
RUN useradd numscipy  
USER numscipy  


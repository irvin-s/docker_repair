FROM asciidoctor/docker-asciidoctor  
MAINTAINER Bogdan Mustiata <bogdan.mustiata@gmail.com>  
  
ENV REFRESHED_AT=2016.11.04-11:54:51  
RUN dnf install -y pygtk2 && \  
pip install shaape  


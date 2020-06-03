from ubuntu:14.04  
maintainer bmamlin  
  
RUN apt-get update; apt-get install -y imagemagick  
  
COPY run.sh /run.sh  
  
VOLUME /images  
  
CMD "/run.sh"


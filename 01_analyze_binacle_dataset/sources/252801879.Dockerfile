FROM ubuntu:latest  
MAINTAINER Edson Lima <dddwebdeveloper@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y octave  
  
CMD ["octave"]  


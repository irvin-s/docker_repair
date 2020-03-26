# Dockerfile to run a linux quake live server  
FROM dpadgett/ql-docker:latest  
MAINTAINER Dan Padgett <dumbledore3@gmail.com>  
  
USER root  
  
RUN apt-get install -y rsync ssh  
COPY setup-server.sh /home/quake/  
  
USER quake  
  
CMD ./setup-server.sh  


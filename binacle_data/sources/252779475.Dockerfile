# Whale Say Fortunes Dockerfile  
# Use the docker/whalesay base image  
FROM docker/whalesay:latest  
  
# File Author / Maintainer  
MAINTAINER Joao Caibar <jc.caibar@gmail.com>  
  
# Install Fortunes (fortunes, fortunes-br).  
RUN apt-get -y update \  
&& apt-get install -y fortunes-br \  
&& apt-get autoremove -y \  
&& apt-get clean -y  
  
CMD /usr/games/fortune -a | cowsay


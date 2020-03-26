FROM docker/whalesay:latest  
MAINTAINER Chris Belyea <chris@chrisbelyea.com>  
RUN apt-get -y update && apt-get install -y fortunes  
CMD /usr/games/fortune -a | cowsay  


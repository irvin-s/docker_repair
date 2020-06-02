#  
# Builds container to capture the links application  
#  
# 2015-03-11 BJS : Created and tested Docker file  
#  
# to build : docker build -t links_app .  
# to run : docker run -it --rm links_app  
#  
FROM debian:jessie  
MAINTAINER Bjarne Sorensen <bjarne@ano.dk>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get install -qy \  
links  
  
RUN mkdir ~/.links2  
  
ENTRYPOINT [ "links" ]  
  
CMD ["http://google.com"]  


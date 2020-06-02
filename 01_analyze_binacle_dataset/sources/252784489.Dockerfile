#  
# Builds container to capture nmap application  
#  
# 2015-03-11 BJS : Created and tested Dockerfile  
#  
# to build : docker build --no-cache -t nmap_app .  
# to run : docker run -it --rm nmap_app  
#  
FROM debian:sid  
MAINTAINER Bjarne Sorensen <bjarne@ano.dk>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get install -qy \  
nmap  
  
ENTRYPOINT [ "nmap" ]  
  
CMD ["localhost"]  


FROM adamprice56/x2go-ubuntu  
MAINTAINER Adam Price <adam@aprice.cf>  
  
# Install KDE suite  
RUN apt-get update -y && apt-get install -y plasma-desktop  


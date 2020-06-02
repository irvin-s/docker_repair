FROM ghost:0.11.4  
MAINTAINER Ferran Vila ferran.vila.conesa@gmail.com  
  
# Create required volumes  
VOLUME ["/var/lib/mysql", "/var/lib/ghost"]  
  
ENTRYPOINT ["/bin/bash"]  


# Docker registry repo/image used as our base  
FROM ctarwater/kali  
  
# Who is responsible for this madness?  
MAINTAINER ctarwater@blackfinsecurity.com  
  
# Install nmap  
RUN apt-get update && \  
apt-get -y install nmap  
  
# Create a non-root user  
RUN useradd -m thastudent && \  
chown -R thastudent:thastudent /home/thastudent  
  
# Issue remaining commands as new user  
USER thastudent  
  
# Issue commands from this directory  
WORKDIR /home/thastudent  
  
# What to execute when container is run  
CMD ["/bin/bash"]


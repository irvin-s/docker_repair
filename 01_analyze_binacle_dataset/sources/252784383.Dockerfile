FROM liling/commander:latest  
MAINTAINER lilingv@gmail.com  
  
ENV VERSION 16.04.02  
# Add user keys  
ADD public_keys /etc/ssh/public_keys  
  
# Setup  
ADD setup.sh /  
RUN bash /setup.sh ; rm -f /setup.sh  


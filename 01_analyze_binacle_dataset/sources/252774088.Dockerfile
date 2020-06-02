#  
# Dockerfile for alyz/devstack  
#  
# Pull base image.  
FROM alyz/devstack:latest  
  
COPY services /etc/services.d  
  
CMD []  


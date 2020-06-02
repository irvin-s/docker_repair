############################################################  
# Dockerfile to build prestashop data container images  
# Based on phusion/baseimage  
############################################################  
# Set the base image to phusion/baseimage  
FROM phusion/baseimage:latest  
VOLUME /var/lib/mysql  
CMD ["true"]  


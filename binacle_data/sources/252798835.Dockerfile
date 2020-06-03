FROM ubuntu:16.04  
LABEL maintainer='devcorpio'  
  
RUN apt-get update && apt-get install -y apache2 && apt-get clean  
  
# Set the log directory PATH  
ENV APACHE_LOG_DIR /var/log/apache2  
  
#foreground because this image is crafted for a sole purpose!  
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]


# Base image  
FROM debian:8.9  
  
MAINTAINER Stefan Preissner <github@cs2.ch>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Update the package repository  
RUN apt-get -qq update  
  
# Install base system  
RUN apt-get install -y varnish  
  
# Clear package cache  
RUN apt-get clean  
  
# Make our custom VCLs available on the container  
ADD default.vcl /etc/varnish/default.vcl  
# Make our custom secret file on the container  
ADD secret /etc/varnish/secret  
  
# Export environment variables  
ENV VARNISH_PORT 80  
  
# Expose port 80  
EXPOSE 80  
  
# ADD start.sh  
ADD start.sh /usr/local/bin/start.sh  
  
# Make script executable  
RUN chmod 0755 /usr/local/bin/start.sh  
  
# Run script  
CMD ["/usr/local/bin/start.sh"]  


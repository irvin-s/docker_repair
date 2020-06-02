FROM ubuntu:14.04  
MAINTAINER Wassilios Lytras "wlytras@hotmail.com"  
ENV REFRESHED_AT 2015-06-14  
  
# Update the package repository and install applications  
RUN apt-get update -qq && \  
apt-get upgrade -yqq && \  
apt-get -yqq install varnish && \  
apt-get -yqq clean  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Make our custom VCLs available on the container  
ADD default.vcl /etc/varnish/default.vcl  
  
ENV VARNISH_BACKEND_PORT 80  
ENV VARNISH_BACKEND_IP 192.168.10.50  
ENV VARNISH_PORT 8081  
  
# Expose port 8081  
EXPOSE 8081  
  
# Expose volumes to be able to use data containers  
# VOLUMES ["/var/lib/varnish", "/etc/varnish"]  
ADD start.sh /start.sh  
CMD ["/start.sh"]  


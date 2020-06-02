FROM debian:jessie  
MAINTAINER Tim Peters <mail@darksecond.nl>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update  
RUN apt-get install -y postfix  
RUN apt-get install -y rsyslog  
RUN apt-get install -y ca-certificates  
  
ADD postfix /etc/postfix  
  
ADD entrypoint.sh /entrypoint.sh  
  
# Configuration for postfix  
# Like virtual-aliases, virtual-domains and virtual-users  
RUN mkdir -p /conf  
  
# We could combine these 3 into one /conf volume  
VOLUME ["/conf/virtual-aliases"]  
VOLUME ["/conf/virtual-domains"]  
VOLUME ["/conf/virtual-users"]  
  
VOLUME ["/certs"]  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
# SMTP  
EXPOSE 25  
# SUBMISSION  
EXPOSE 587  
# SMTPS  
EXPOSE 465  


FROM ubuntu:16.04  
MAINTAINER technopreneural@yahoo.com  
  
# Install latest updates (security best practice)  
RUN apt-get update \  
&& apt-get upgrade -y \  
  
# Install packages (without asking for user input)  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y \  
bind9 \  
bind9utils \  
bind9-doc \  
  
# Remove repo lists (reduce image size)  
&& rm -rf /var/lib/apt/lists/*  
  
# Configuration and zone data  
VOLUME ["/etc/bind"]  
  
# Expose default port for DNS  
EXPOSE 53  
# Run daemon as PID 1  
ENTRYPOINT ["/usr/sbin/named", "-f"]  


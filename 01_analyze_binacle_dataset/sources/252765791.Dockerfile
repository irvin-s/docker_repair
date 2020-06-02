FROM debian:8.2  
MAINTAINER Elisey Zanko <elisey.zanko@gmail.com>  
  
# Install Supervisor  
RUN apt-get update && apt-get install -y \  
supervisor \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# Download and install Factom  
ADD http://factom.org/downloads/factom.deb ./  
RUN dpkg --force-architecture -i factom.deb  
  
# Copy configs  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
COPY factomd.conf /root/.factom/  
  
EXPOSE 8088 8089 8090  
CMD ["/usr/bin/supervisord"]  


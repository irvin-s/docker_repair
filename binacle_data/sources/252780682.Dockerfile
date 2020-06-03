FROM ubuntu:14.04  
MAINTAINER scadgek@live.com  
  
RUN apt-get update && \  
apt-get install -y \  
apt-transport-https \  
ca-certificates \  
curl \  
iptables \  
lxc \  
supervisor  
  
# Install Docker from Docker Inc. repositories.  
RUN curl -sSL https://get.docker.com/ | sh  
  
# Install Node.js v0.12  
RUN curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -  
RUN apt-get install -y nodejs  
  
# Install required npm modules  
RUN npm install \  
body-parser \  
express \  
backendless  
  
# Install the magic wrapper.  
ADD ./wrapdocker /usr/local/bin/wrapdocker  
RUN chmod +x /usr/local/bin/wrapdocker  
  
# Define additional metadata for our image.  
VOLUME /var/lib/docker  
  
# Create log folder for supervisor, docker and scriptexec  
RUN mkdir -p /var/log/supervisor  
RUN mkdir -p /var/log/docker  
RUN mkdir -p /var/log/ipcontrol  
  
ADD ./restart_scriptexec.sh /restart_scriptexec.sh  
RUN chmod +x /restart_scriptexec.sh  
ADD ./ipcontrol.js /ipcontrol.js  
ADD ./src/index.js /src/index.js  
  
COPY supervisord.conf /etc/supervisor/conf.d/supervisor.conf  
  
EXPOSE 3000 4444  
CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisor.conf" ]  


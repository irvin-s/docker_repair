FROM ubuntu:14.04  
MAINTAINER jerome.petazzoni@docker.com  
  
# Let's start with some basic stuff.  
RUN apt-get update -qq && apt-get install -qqy \  
apt-transport-https \  
ca-certificates \  
curl \  
lxc \  
iptables \  
ethtool  
  
# Install Docker from Docker Inc. repositories.  
RUN curl -sSL https://get.docker.com/ | sh  
  
# Install the magic wrapper.  
ADD ./wrapdocker /usr/local/bin/wrapdocker  
ADD ./clean.sh /clean.sh  
ADD ./iplist.sh /iplist.sh  
ADD ./startfarm.sh /startfarm.sh  
RUN chmod +x clean.sh  
RUN chmod +x iplist.sh  
RUN chmod +x startfarm.sh  
RUN chmod +x /usr/local/bin/wrapdocker  
  
# Define additional metadata for our image.  
VOLUME /var/lib/docker  
CMD ["wrapdocker"]  


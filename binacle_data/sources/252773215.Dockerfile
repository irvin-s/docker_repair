#  
# Haproxy Dockerfile  
#  
# https://github.com/bhang/haproxy  
#  
# Pull base image.  
FROM ubuntu:14.04  
# Install deps in order to add PPA  
RUN apt-get -qq update && apt-get -y install software-properties-common  
  
# Add haproxy PPA  
RUN add-apt-repository ppa:vbernat/haproxy-1.5  
  
# Install Haproxy.  
RUN \  
apt-get update && \  
apt-get install -y haproxy && \  
sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy  
  
# Add files.  
ADD haproxy.cfg /etc/haproxy/haproxy.cfg  
ADD start.bash /haproxy-start  
  
# Define mountable directories.  
VOLUME ["/data", "/haproxy-override"]  
  
# Define working directory.  
WORKDIR /etc/haproxy  
  
# Define default command.  
CMD ["bash", "/haproxy-start"]  
  
# Expose ports.  
EXPOSE 80  
EXPOSE 443  


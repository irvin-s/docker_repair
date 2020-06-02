FROM ubuntu:xenial  
MAINTAINER Chris Hardekopf <chrish@basis.com>  
  
# Install gitolite  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y locales gitolite3 && \  
rm -rf /var/lib/apt/lists/*  
  
# Get the locale set up for perl and make sure sshd can run  
RUN locale-gen en_US.UTF-8 && \  
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales && \  
sed -i 's/^AcceptEnv LANG LC_\\*$//g' /etc/ssh/sshd_config && \  
mkdir /var/run/sshd  
  
# Add the start script  
ADD start /opt/  
  
# The git archives are stored under the user home directory (specified at run)  
VOLUME [ "/home" ]  
  
# Expose the ssh port  
EXPOSE 22  
# Run the ssh server  
CMD [ "/opt/start" ]  


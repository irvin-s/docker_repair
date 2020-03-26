# FROM dockerfile/ubuntu
FROM phusion/baseimage:0.9.11

MAINTAINER Michiel van Oosten

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ADD docker/scripts /root/scripts
ADD docker/.bashrc /root/
ADD docker/.z /root/
ADD docker/.gitconfig /root/

# setting environment variables
RUN echo "/root" > /etc/container_environment/HOME

# my build instructions:

RUN apt-get update
RUN apt-get install rlwrap wget

# haproxy 
# RUN   \
#     cd /opt && \
#     apt-get install -qq build-essential libssl-dev libev-dev wget rlwrap&& \
#     wget http://www.haproxy.org/download/1.5/src/haproxy-1.5.1.tar.gz && \
#     tar xzvf haproxy-1.5.1.tar.gz && \
#     cd haproxy-1.5.1 && \
#     make TARGET=linux26 USE_OPENSSL=1 && \ 
#     sudo make install && \
#     rm -rf /opt/haproxy-1.5.1 && \
#     rm -f /opt/haproxy-1.5.1.tar.gz

# or just:    
ADD docker/haproxy /usr/local/sbin/

RUN useradd haproxy    

# serf
ADD docker/serf /usr/local/sbin

# ADD docker/node /opt/node #one can add the node dir to the project instead perhaps

# # Install Node 
RUN   \
  cd /opt && \
  wget http://nodejs.org/dist/v0.10.28/node-v0.10.28-linux-x64.tar.gz && \
  tar -xzf node-v0.10.28-linux-x64.tar.gz && \
  mv node-v0.10.28-linux-x64 node && \

  cd /usr/local/bin && \
  ln -s /opt/node/bin/* . && \
  rm -f /opt/node-v0.10.28-linux-x64.tar.gz

RUN \
   npm install -g nodemon 

# Set the working directory
WORKDIR   /src

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

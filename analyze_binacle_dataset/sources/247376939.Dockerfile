# image to use
FROM debian:jessie

# apt-get what we need
RUN apt update && apt install -y \
  telnet \
  vim \
  nano \
  net-tools \
  wget \
  memcached

# root .bashrc
RUN echo "PS1='\[\e[31m\]\u\[\e[m\]@\h:\w\$ '" >> /root/.bashrc
RUN echo "alias ll='ls -la'" >> /root/.bashrc
RUN echo "export TERM=xterm" >> /root/.bashrc

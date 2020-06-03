FROM ubuntu:xenial  
  
ARG DEBIAN_FRONTEND=noninteractive  
  
# Install all the necessary packages  
RUN apt-get update && \  
apt install -y lcov \  
clang \  
libev-dev \  
libc-ares-dev \  
libstdc++-4.8-dev \  
libidn2-0-dev \  
libssh2-1-dev \  
krb5-user \  
git \  
make \  
autoconf \  
libtool  


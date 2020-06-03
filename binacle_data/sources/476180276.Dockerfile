# HAProxy
# @version 1.5.3
# @author Lorenzo Fontana <fontanalorenzo@me.com>
FROM centos:latest

MAINTAINER Lorenzo Fontana, fontanalorenzo@me.com

# Prerequisites
RUN yum install -y wget openssl-devel pcre-devel make gcc tar

# Download HAProxy and extract
RUN wget -nv -O - http://www.haproxy.org/download/1.5/src/haproxy-1.5.3.tar.gz | tar zx

# Compile for Linux 2.6.28, 3.x, and above with PCRE, OPENSSL and ZLIB using native CPU optimizations
WORKDIR haproxy-1.5.3 
RUN make TARGET=linux2628 CPU=native USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 && make install

WORKDIR /

# Symlink binaries
RUN cp -as /usr/local/sbin/haproxy* /usr/sbin

# Create haproxy configuration directory
RUN mkdir /etc/haproxy

# Add haproxy user
RUN useradd haproxy

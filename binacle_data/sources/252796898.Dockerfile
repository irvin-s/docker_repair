#  
# ZeroMQ Message Platform  
# Builds a container for developing the Message Platform  
#  
FROM ubuntu  
  
MAINTAINER Howard Young "https://github.com/threadx"  
RUN apt-get update --fix-missing  
  
RUN apt-get install -y g++  
RUN apt-get install -y make  
RUN apt-get install -y xutils-dev  
RUN apt-get install -y libtool  
RUN apt-get install -y automake  
  
#  
# Required libs  
#  
RUN apt-get install -y libzip-dev  
RUN apt-get install -y libcurl4-openssl-dev  
RUN apt-get install -y libxml2-dev  
  
#  
# Other Utils  
#  
RUN apt-get install -y wget  
RUN apt-get install -y traceroute  
RUN apt-get install -y unzip  
RUN apt-get install -y git  
  
#  
# vi just doesn't cut it anymore  
#  
RUN apt-get install -y vim  
  
RUN git clone git://github.com/jedisct1/libsodium.git  
RUN cd libsodium; ./autogen.sh; ./configure && make; make install; ldconfig  
  
RUN git clone git://github.com/zeromq/libzmq.git  
RUN cd libzmq; ./autogen.sh; ./configure && make; make install; ldconfig  
  
RUN git clone git://github.com/zeromq/czmq.git  
RUN cd czmq; ./autogen.sh; ./configure && make; make install; ldconfig  
  
#  
# Message Platform  
#  
RUN mkdir -p /var/log/mp  
  
cmd /bin/bash  


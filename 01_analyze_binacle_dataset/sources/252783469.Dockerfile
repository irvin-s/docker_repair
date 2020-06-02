FROM debian:jessie  
MAINTAINER Stijn Debrouwere <stijn@debrouwere.org>  
  
RUN apt-get update  
RUN apt-get -y upgrade  
RUN apt-get -y install make build-essential libtool libncurses5-dev  
RUN apt-get -y install openssl libssl-dev  
RUN apt-get -y install wget unzip  
RUN apt-get -y install lua5.2 liblua5.2-dev  
# the luarocks distributed through the package  
# manager causes all kinds of trouble  
RUN wget http://luarocks.org/releases/luarocks-2.2.0.tar.gz && \  
tar zxvpf luarocks-2.2.0.tar.gz && \  
cd luarocks-2.2.0 && \  
./configure && \  
make build && \  
make install  
RUN luarocks install luasec OPENSSL_LIBDIR=/usr/lib/x86_64-linux-gnu  
  
# optimize docker caching by installing jobs dependencies first  
COPY ./rockspec/jobs-dependencies-*.rockspec /jobs/rockspec/  
RUN luarocks make /jobs/rockspec/jobs-dependencies-1.rockspec  
# install jobs binaries  
COPY . /jobs  
WORKDIR /jobs  
RUN luarocks make rockspec/jobs-scm-1.rockspec


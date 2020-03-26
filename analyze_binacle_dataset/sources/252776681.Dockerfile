FROM debian:jessie  
MAINTAINER Daniel Pinto <cayan@programmer.net>  
  
RUN apt-get update && apt-get install -y \  
g++ \  
make \  
cmake \  
autoconf \  
automake \  
build-essential \  
pkg-config \  
libxml2-dev \  
libpugixml-dev \  
lua-sql-mysql \  
lua-sql-mysql-dev \  
liblua5.1-0-dev \  
liblua5.2-dev \  
libgmp3-dev \  
libboost-all-dev \  
libboost-system-dev \  
libmysqlclient-dev \  
\--no-install-recommends && rm -r /var/lib/apt/lists/*  
  
WORKDIR /server  


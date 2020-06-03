FROM debian:9  
MAINTAINER CreepCat <Centra1C0re@hotmail.com>  
  
RUN apt-get update -qq && apt-get install -qqy \  
automake \  
libcurl4-openssl-dev \  
git \  
make \  
build-essential && \  
apt-get clean  
  
RUN git clone \--recursive https://github.com/OhGodAPet/cpuminer-multi.git  
  
RUN cd cpuminer-multi && ./autogen.sh && ./configure CFLAGS="-O3" && make  
  
WORKDIR /cpuminer-multi  
  
ENTRYPOINT ["./minerd"]  


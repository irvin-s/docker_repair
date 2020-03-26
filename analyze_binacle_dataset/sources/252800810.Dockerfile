FROM ubuntu:14.10  
RUN apt-get update  
RUN apt-get -y install unzip wget  
RUN apt-get -y install libtool autoconf make  
  
WORKDIR /usr/src  
RUN wget https://github.com/rtCamp/httperf/archive/master.zip  
RUN unzip master.zip  
WORKDIR /usr/src/httperf-master  
RUN mkdir build  
RUN autoreconf -i  
RUN ./configure  
RUN make  
RUN make install  
  
WORKDIR /  


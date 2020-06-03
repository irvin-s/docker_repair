FROM ubuntu:16.04 AS builder  
  
RUN apt-get update \  
&& apt-get install --yes --no-install-recommends \  
build-essential cmake libboost-program-options-dev libgmp-dev file  
  
COPY . /opt/src  
WORKDIR /opt/build  
  
RUN cmake ../src -DSTATIC_LINK=ON && make && make test  
  
FROM ubuntu:16.04  
COPY \--from=builder /opt/build/tutte /usr/local/bin  


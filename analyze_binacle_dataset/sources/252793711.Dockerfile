FROM ubuntu:latest  
  
RUN apt-get update -qq && \  
apt-get install -qqy build-essential automake libcurl4-openssl-dev git make  
  
RUN git clone https://github.com/pooler/cpuminer  
  
RUN cd cpuminer && \  
./autogen.sh && \  
./configure CFLAGS="-O3" && \  
make  
  
WORKDIR /cpuminer  
ENTRYPOINT ["./minerd"]  


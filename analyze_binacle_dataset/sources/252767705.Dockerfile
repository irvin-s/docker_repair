FROM debian:stretch  
  
MAINTAINER Marcel Brand <marcel.brand@achtachtel.de>  
  
# Run update and install dependencies  
RUN apt-get update && apt-get install -y \  
cmake \  
gcc \  
g++ \  
libboost-all-dev \  
libiomp-dev \  
openssl \  
libssl-dev \  
googletest && apt-get clean


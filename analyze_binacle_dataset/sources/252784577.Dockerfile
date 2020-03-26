FROM bl4ck5un/sgx-docker  
MAINTAINER Fan Zhang <bl4ck5unxx@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y \  
libssl-dev \  
libjsoncpp-dev libjsonrpccpp-dev libjsonrpccpp-tools \  
libboost-all-dev \  
libmicrohttpd-dev \  
liblog4cxx-dev  


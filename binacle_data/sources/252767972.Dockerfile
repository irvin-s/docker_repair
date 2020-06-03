FROM miksago/ubuntu-go  
  
MAINTAINER Adam Alexander <adamalex@gmail.com>  
  
RUN cd /root && \  
git clone https://github.com/coreos/fleet.git && \  
cd fleet && \  
./build  


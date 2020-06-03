FROM debian:jessie  
  
MAINTAINER Dimitri Justeau <dimitri.justeau@gmail.com>  
  
# Update and install git  
RUN apt-get update && apt-get install -y git  
  
# Install cmake  
RUN apt-get install -y g++ cmake  
  
# Clone BAMM from github  
RUN git clone https://github.com/macroevolution/bamm.git  
  
# Install BAMM  
RUN cd bamm \  
&& mkdir build \  
&& cd build \  
&& cmake .. \  
&& make -j \  
&& make install  
  
CMD /bin/bash  


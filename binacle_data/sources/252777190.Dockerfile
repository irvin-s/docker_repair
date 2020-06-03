FROM cepr/ubuntu-xenial-microchip-xc8  
  
# Install Qt5  
RUN \  
apt-get update && \  
apt-get install -y \  
qt5-default  
  
# Build and install libgerv-dev  
# Note: there is no Ubuntu package for libgerbv-dev  
RUN \  
apt-get update && \  
apt-get build-dep -y gerbv && \  
apt-get source -y gerbv && \  
cd gerbv-2.6.0 && \  
dpkg-buildpackage && \  
make install  
  


FROM ubuntu:14.04  
MAINTAINER David Freese <dfreese@stanford.edu>  
  
USER root  
  
RUN apt-get update  
  
RUN apt-get -y install wget cmake cmake-curses-gui build-essential \  
libqt4-opengl libqt4-opengl-dev qt4-qmake libqt4-dev libx11-dev \  
libxmu-dev libxpm-dev libxft-dev  
  
RUN mkdir -p ~/GEANT4/source; \  
cd ~/GEANT4/source; \  
wget http://geant4.cern.ch/support/source/geant4.10.01.tar.gz  
  
RUN cd ~/GEANT4/source; \  
tar -xzf geant4.10.01.tar.gz  
  
RUN mkdir -p ~/GEANT4/build; \  
cd ~/GEANT4/build; \  
cmake ~/GEANT4/source/geant4.10.01 -DGEANT4_BUILD_MULTITHREADED=ON \  
-DGEANT4_USE_QT=ON -DGEANT4_USE_OPENGL_X11=ON \  
-DGEANT4_USE_RAYTRACER_X11=ON -DGEANT4_INSTALL_DATA=ON \  
-Wno-dev; \  
make -j`grep -c processor /proc/cpuinfo`; \  
make install; \  
echo ' . geant4.sh' >> ~/.bashrc  


FROM ubuntu:16.04  
MAINTAINER Adrián García Espinosa "age.apps.dev@gmail.com"  
# Update and install dependencies  
RUN \  
apt-get update -y && \  
apt-get upgrade -y && \  
apt-get install -y subversion gcc software-properties-common make zlib1g-dev  
  
WORKDIR /encoder  
  
# Install MP4Box from gpac  
RUN \  
svn co https://svn.code.sf.net/p/gpac/code/trunk/gpac gpac && \  
cd gpac && \  
chmod +x configure && \  
./configure && \  
make && \  
make install && \  
cp bin/gcc/libgpac.so /usr/lib  
  
# Install ffmmpeg with x264 encoder  
RUN \  
add-apt-repository ppa:jonathonf/ffmpeg-3 && \  
apt-get update -y && \  
apt install ffmpeg libav-tools x264 -y  
  
COPY convert.sh .  
  


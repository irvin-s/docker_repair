FROM ubuntu:16.04  
  
RUN apt-get update && apt-get install -y \  
build-essential \  
cmake \  
curl \  
gfortran \  
git \  
graphicsmagick \  
libgraphicsmagick1-dev \  
libatlas-dev \  
libavcodec-dev \  
libavformat-dev \  
libboost-all-dev \  
libgtk2.0-dev \  
libjpeg-dev \  
liblapack-dev \  
libswscale-dev \  
pkg-config \  
python-dev \  
python-numpy \  
python-protobuf\  
software-properties-common \  
zip \  
sudo \  
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN git clone https://github.com/torch/distro.git ~/torch --recursive  
RUN cd ~/torch && bash install-deps && ./install.sh && \  
cd install/bin && \  
./luarocks install nn && \  
./luarocks install dpnn && \  
./luarocks install image && \  
./luarocks install optim && \  
./luarocks install csvigo && \  
./luarocks install torchx && \  
./luarocks install tds  
RUN ln -s ~/torch/install/bin/* /usr/local/bin  
  
RUN apt-get update && apt-get install -y python-opencv  
  
RUN cd ~ && \  
mkdir -p dlib-tmp && \  
cd dlib-tmp && \  
curl -L \  
https://github.com/davisking/dlib/archive/v19.3.tar.gz \  
-o dlib.tar.bz2 && \  
tar xf dlib.tar.bz2 && \  
cd dlib-19.3/python_examples && \  
mkdir build && \  
cd build && \  
cmake ../../tools/python && \  
cmake --build . --config Release && \  
cp dlib.so /usr/local/lib/python2.7/dist-packages && \  
rm -rf ~/dlib-tmp  


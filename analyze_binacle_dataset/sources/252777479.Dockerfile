FROM ubuntu:14.04.5  
MAINTAINER Chakkrit Termritthikun <chakkritte57@nu.ac.th>  
  
RUN apt-get -q -y update && apt-get install -q -y \  
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
wget \  
ipython3 \  
libssl-dev \  
libzmq3-dev \  
python-zmq \  
python-pip \  
&& apt-get upgrade -q -y \  
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
  
RUN \  
git clone https://github.com/torch/distro.git ~/torch --recursive && \  
cd ~/torch; bash install-deps;  
  
RUN \  
chmod a+x /root/torch/install.sh  
  
RUN \  
cd ~/torch && \  
./install.sh && \  
cd install/bin && \  
./luarocks install nn && \  
./luarocks install dpnn && \  
./luarocks install image && \  
./luarocks install optim && \  
./luarocks install csvigo && \  
./luarocks install torchx && \  
./luarocks install tds  
  
  
RUN cd ~ && \  
mkdir -p ocv-tmp && \  
cd ocv-tmp && \  
curl -L https://github.com/opencv/opencv/archive/2.4.12.3.zip -o ocv.zip && \  
unzip ocv.zip && \  
cd opencv-2.4.12.3 && \  
mkdir release && \  
cd release && \  
cmake -D CMAKE_BUILD_TYPE=RELEASE \  
-D CMAKE_INSTALL_PREFIX=/usr/local \  
-D BUILD_PYTHON_SUPPORT=ON \  
.. && \  
make -j8 && \  
make install && \  
rm -rf ~/ocv-tmp  
  
RUN cd ~ && \  
mkdir -p dlib-tmp && \  
cd dlib-tmp && \  
curl -L \  
https://github.com/davisking/dlib/archive/v19.0.tar.gz \  
-o dlib.tar.bz2 && \  
tar xf dlib.tar.bz2 && \  
cd dlib-19.0/python_examples && \  
mkdir build && \  
cd build && \  
cmake ../../tools/python && \  
cmake --build . --config Release && \  
cp dlib.so /usr/local/lib/python2.7/dist-packages && \  
rm -rf ~/dlib-tmp  


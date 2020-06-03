FROM alpine:3.6  
  
RUN buildDeps="git \  
make \  
bash \  
autoconf \  
nasm \  
g++ \  
automake \  
libtool \  
libjpeg-turbo-dev \  
linux-headers \  
cmake \  
sudo" && \  
apk add --no-cache --update ${buildDeps} && \  
apk add libstdc++ libjpeg-turbo && \  
git clone https://github.com/google/zopfli.git && \  
cd zopfli && \  
make libzopflipng && \  
cp libzopflipng.so.1.0.0 /usr/lib && \  
ln -s libzopflipng.so.1.0.0 /usr/lib/libzopflipng.so && \  
ln -s libzopflipng.so.1.0.0 /usr/lib/libzopflipng.so.1 && \  
mkdir /usr/include/zopflipng && \  
cp src/zopflipng/zopflipng_lib.h /usr/include/zopflipng && \  
cd .. && \  
git clone https://github.com/Lymphatus/libcaesium.git && \  
cd libcaesium && \  
mkdir build && \  
cd build && \  
cmake .. && \  
make && \  
sudo make install && \  
git clone https://github.com/Lymphatus/caesium-clt.git && \  
cd caesium-clt && \  
mkdir build && \  
cd build && \  
cmake .. && \  
make && \  
sudo make install && \  
rm -rf /libcaesium && \  
apk del ${buildDeps} && \  
rm -rf /var/cache/apk/*  
  
WORKDIR /caesium  


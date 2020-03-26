FROM ubuntu  
MAINTAINER Jacques Moati <jacques@moati.net>  
  
RUN apt-get update && \  
apt-get install -y build-essential cmake git wget unzip qt5-default && \  
cd /root && \  
wget https://github.com/Itseez/opencv/archive/3.1.0.zip && \  
unzip 3.1.0.zip && \  
rm 3.1.0.zip && \  
git clone https://github.com/opencv/opencv_contrib.git && \  
cd /root/opencv_contrib && \  
git checkout 6dc1f416a0b3d912f4fdad1b307cccf0300571b4 && \  
mkdir build && \  
cd /root/opencv_contrib/build && \  
cmake -DOPENCV_EXTRA_MODULES_PATH=../modules ../../opencv-3.1.0/ && \  
make -j8 && \  
make install && \  
echo "/usr/local/opencv/" > /usr/local/opencv2 && \  
ldconfig -v


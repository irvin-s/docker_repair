FROM avatao/web-ide:ubuntu-14.04  
# Install common packages  
RUN apt-get -qy update \  
&& apt-get -qy install \  
cmake \  
valgrind \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY . /  
  
# Install 3rd-party software  
RUN cd /usr/src/cmocka \  
&& mkdir build \  
&& cd build \  
&& cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release .. \  
&& make \  
&& make install \  
&& make clean  


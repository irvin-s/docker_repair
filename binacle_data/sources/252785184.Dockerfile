ARG tag="latest"  
FROM cognexa/cxflow-tensorflow:"${tag}"  
MAINTAINER Cognexa Solutions s.r.o. <docker@cognexa.com>  
  
# install extra packages  
RUN pacman --noconfirm --needed -S \  
base-devel \  
boost \  
cmake \  
clang \  
git \  
openmp \  
openssh \  
yaml-cpp \  
&& paccache -rfk0  
  
# install cxtream  
RUN git clone \--recursive https://github.com/Cognexa/cxtream.git \  
&& mkdir -p cxtream/build && cd cxtream/build \  
&& cmake -DBUILD_TEST=OFF .. \  
&& make -j4 && make install && ldconfig \  
&& cd ../../ && rm -r cxtream  


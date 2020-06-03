FROM gcc:latest  
  
RUN apt-get update \  
&& apt-get install -y g++ cmake git  
  
RUN git clone \--depth 1 --branch=master https://github.com/Snaipe/Criterion \  
&& cd Criterion \  
&& mkdir build \  
&& cd build \  
&& cmake \  
.. \  
-DCMAKE_BUILD_TYPE=RelWithDebInfo \  
-DCMAKE_INSTALL_PREFIX=/usr \  
-DCMAKE_INSTALL_LIBDIR=lib \  
&& make \  
&& make install \  
&& cd ../../ && rm -Rf Criterion  
  
VOLUME /tests  
WORKDIR /tests  
  
ENV TEST_FILE=sample  
CMD gcc \  
-o build/$TEST_FILE $TEST_FILE.c \  
-lcriterion \  
&& build/$TEST_FILE  


FROM gcc:7  
  
RUN set -ex; \  
apt-get update; \  
apt-get install -y --no-install-recommends \  
bison \  
cmake \  
flex \  
gdb \  
cppcheck \  
libcppunit-dev \  
valgrind; \  
rm -rf /var/lib/apt/lists/*  
RUN git clone https://github.com/doxygen/doxygen.git; \  
cd doxygen; \  
git checkout Release_1_8_13; \  
mkdir build; \  
cd build; \  
cmake -G "Unix Makefiles" ..; \  
make; \  
make install; \  
cd ../..; \  
rm -rf doxygen/; \  
apt-get remove --purge -y bison cmake flex; \  
apt-get autoremove -y  


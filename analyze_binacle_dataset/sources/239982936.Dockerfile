FROM ubuntu:bionic

RUN apt-get update && apt-get install -y cmake g++ git libboost-all-dev libwebsocketpp-dev openssl libssl-dev ninja-build libxml2-dev uuid-dev kmod libfuse-dev

RUN git clone https://github.com/Microsoft/cpprestsdk.git && cd cpprestsdk/Release && mkdir build.debug && cd build.debug && cmake .. -DCMAKE_BUILD_TYPE=Debug && make install

RUN git clone https://github.com/Azure/azure-storage-cpp.git && cd azure-storage-cpp/Microsoft.WindowsAzure.Storage && mkdir build.debug && cd build.debug && CASABLANCA_DIR=../cpprestsdk cmake .. -DCMAKE_BUILD_TYPE=Debug && make install

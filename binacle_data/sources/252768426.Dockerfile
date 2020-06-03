FROM ubuntu:latest  
  
RUN apt-get update  
RUN apt-get install git build-essential autoconf libtool -y  
  
COPY protobuf-cpp-3.0.0-beta-2.tar.gz /tmp/protobuf-cpp-3.0.0-beta-2.tar.gz  
  
WORKDIR /tmp  
RUN tar -zxvf protobuf-cpp-3.0.0-beta-2.tar.gz  
  
WORKDIR /tmp/protobuf-3.0.0-beta-2  
RUN ./autogen.sh  
RUN ./configure  
RUN make  
RUN make check  
RUN make install  
RUN ldconfig  
RUN rm -r /tmp/*  
  
WORKDIR /  
RUN git clone https://github.com/grpc/grpc.git  
  
WORKDIR /grpc  
RUN git submodule update --init  
RUN make  
RUN make install  
  
COPY gen.bash /usr/local/bin  
RUN chmod +x /usr/local/bin/gen.bash  
  
ENTRYPOINT ["gen.bash"]  
  


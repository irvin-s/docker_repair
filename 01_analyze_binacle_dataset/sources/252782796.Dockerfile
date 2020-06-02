FROM fedora:latest  
MAINTAINER Daehyun You <daehyun@mail.tagen.tohoku.ac.jp>  
  
RUN dnf update -y && dnf install -y \  
@'C Development Tools and Libraries' \  
cmake rpm-build gdb-gdbserver \  
boost-devel rapidjson-devel \  
root root-roofit \  
&& dnf clean all  
  
WORKDIR /root/  
ADD ./ /opt/sp8-analysis/  
RUN mkdir build && cd build \  
&& cmake /opt/sp8-analysis/ -DCMAKE_BUILD_TYPE=Release \  
&& cpack && make all && make install  
  
CMD bash  


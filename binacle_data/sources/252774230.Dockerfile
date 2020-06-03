FROM ubuntu:trusty  
MAINTAINER Amit Bakshi <ambakshi@gmail.com>  
  
## This is a fix for Debian Sid.  
#RUN ln -s plat-x86_64-linux-gnu/_sysconfigdata_nd.py /usr/lib/python2.7/  
RUN apt-get update && apt-get upgrade -y  
RUN apt-get install -y build-essential git subversion cmake \  
librpm-dev librpmbuild3 librpmsign1 rpm2cpio rpm \  
python2.7 ninja-build bundler libncurses5-dev  
ENV CLANG_VERSION=3.8 BUILD_NUMBER=0  
RUN mkdir -p /code  
WORKDIR /code  
ADD ./Makefile /code/  
ADD ./Gemfile /code/  
RUN make checkout  
RUN make -j8 build  
RUN make package  
VOLUME ["/usr/src","/code/build","/pkg"]  
CMD ["/bin/bash","-l"]  


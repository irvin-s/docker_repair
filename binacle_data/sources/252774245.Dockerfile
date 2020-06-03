FROM centos:7  
RUN yum install -y wget  
RUN yum install -y epel-release  
RUN yum install -y mingw64*  
RUN yum install -y which vim  
  
ENV CXX=/usr/bin/x86_64-w64-mingw32-g++  
ENV CC=/usr/bin/x86_64-w64-mingw32-gcc  
ENV FC=/usr/bin/x86_64-w64-mingw32-gfortran  
  
# AMBER  
RUN yum install -y wine  
RUN yum install -y tcsh patch bison flex make git  
RUN yum install -y unzip  
  
ADD mingw64_dll.zip /root/  
RUN cd /root/ && unzip mingw64_dll.zip  
RUN rm /root/mingw64_dll.zip  


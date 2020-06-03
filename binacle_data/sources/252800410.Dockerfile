FROM fedora:latest  
MAINTAINER Dolphinics  
RUN dnf -y install git make autoconf libtool gcc gcc-c++ glibc-devel libgcc \  
rpm-build kernel kernel-devel which qt-devel elfutils-libelf-devel  
#install fake uname  
COPY uname.sh /  
RUN /uname.sh --install $(ls /usr/src/kernels | head -n 1)  


FROM centos:latest  
  
MAINTAINER RJ Nowling <rnowling@gmail.com>  
  
RUN yum -y clean all  
RUN yum -y update  
  
RUN yum -y install epel-release  
RUN yum -y install gcc gcc-c++  
RUN yum -y install python-devel  
RUN yum -y install numpy scipy  
RUN yum -y install Cython  
RUN yum -y install gsl gsl-devel  
RUN yum -y install wget git  
  
RUN git clone https://github.com/rajanil/fastStructure  
WORKDIR /fastStructure/vars  
RUN python setup.py build_ext --inplace  
WORKDIR /fastStructure  
RUN python setup.py build_ext --inplace  
ENTRYPOINT ["/usr/bin/bash", "-c"]  
  


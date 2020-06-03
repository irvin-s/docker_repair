FROM centos:latest  
  
MAINTAINER RJ Nowling <rnowling@gmail.com>  
  
RUN yum -y clean all  
RUN yum -y update  
  
RUN yum -y install epel-release  
RUN yum -y install gcc gcc-c++  
RUN yum -y install glibc-static libstdc++-static  
RUN yum -y install make  
RUN yum -y install wget git  
RUN yum -y install tar bzip2  
  
RUN git clone https://github.com/bedops/bedops.git  
WORKDIR /bedops  
RUN make  
RUN make install  
RUN cp bin/* /usr/local/bin  
WORKDIR /  
  
ENTRYPOINT ["/usr/bin/bash", "-c"]  


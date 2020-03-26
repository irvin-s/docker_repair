FROM centos:centos6  
MAINTAINER tony.bussieres@ticksmith.com  
  
RUN yum groupinstall -y "Development Tools"  
RUN yum install -y wget tar zlib-devel  
  
ADD build.sh /bin/build.sh  
  
RUN /bin/build.sh  
  
CMD /bin/bash  
  


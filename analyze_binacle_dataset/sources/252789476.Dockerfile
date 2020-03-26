FROM centos:7  
MAINTAINER "Andrew Nelson" <andrew@dummydata.com>  
  
RUN yum -y install genisoimage  
RUN yum -y update; yum clean all  
  
CMD ["/usr/bin/mkisofs", "--help"]  


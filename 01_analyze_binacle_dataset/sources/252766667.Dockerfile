FROM centos:6  
MAINTAINER Andrew Kroh (andy@crowbird.com)  
  
RUN yum -y update && yum clean all  
CMD ["true"]  


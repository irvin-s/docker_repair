FROM centos:latest  
MAINTAINER Jasper Aikema <jaikema@it-ernity.nl>  
  
# Update base image  
RUN yum -y update && yum clean all  
  
# Sleep for 60m then exit  
CMD ["sleep", "60m"]  


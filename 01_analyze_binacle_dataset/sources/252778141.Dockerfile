FROM appliedis/centos-gosu:7  
MAINTAINER Jonathan Meyer <jon@gisjedi.com>  
  
# Update and install python-pip  
RUN yum -y update && \  
yum -y install epel-release && \  
yum -y install python-pip && \  
yum clean all  
  
CMD ["python"]  


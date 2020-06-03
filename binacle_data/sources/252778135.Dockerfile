FROM appliedis/centos-gosu:7  
MAINTAINER Jonathan Meyer <jon@gisjedi.com>  
  
# Update, install and cleanup  
RUN yum -y install java-1.8.0-openjdk \  
&& yum clean all  
  


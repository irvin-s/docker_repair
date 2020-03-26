FROM deliveryagent/centos  
MAINTAINER Tommy McNeely <tommy@lark-it.com>  
  
RUN yum -y install nodejs npm; \  
yum clean all  
  


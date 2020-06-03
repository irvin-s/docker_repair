FROM centos:7  
RUN yum update -y \  
&& yum install -y epel-release \  
&& yum install -y stress  
  
ENTRYPOINT [ "stress" ]  
  
CMD [ "--verbose" ]


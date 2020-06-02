FROM amazonlinux:2017.03  
RUN yum install -y epel-release && \  
yum install -y rpmdevtools yum-utils fakeroot && \  
yum clean all  


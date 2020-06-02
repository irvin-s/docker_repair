FROM amazonlinux:1  
RUN yum -y install python36 python36-virtualenv \  
zip unzip \  
git aws-cli \  
&& yum clean all  


FROM centos:latest  
  
MAINTAINER Victor Augusteo  
  
RUN curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -  
RUN yum -y update \  
&& yum -y install openssh openssh-server openssh-clients openssl-libs \  
rsync \  
which \  
nodejs gcc-c++ make \  
gcc \  
wget \  
&& yum clean all  
RUN wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo  
RUN yum -y install yarn  
RUN npm install -g node-sass


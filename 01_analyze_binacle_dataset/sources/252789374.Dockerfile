FROM duffqiu/dev-tools:latest  
MAINTAINER duffqiu@gmail.com  
  
RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7  
RUN yum -y install epel-release  
RUN yum -y update  
RUN yum install -y wget golang hg git  
RUN yum install -y tar nodejs npm  
RUN yum install -y ruby ruby-devel  
RUN npm install -g bower  
RUN npm install -g grunt  
RUN npm install -g grunt-cli  
RUN npm install -g grunt-connect-proxy  
RUN npm install -g eventemitter3@0.1.6  
RUN npm install -g grunt-contrib-compass  
RUN npm install -g yo  
RUN gem install compass  
  
RUN mkdir -p /root/go  
ENV GOPATH=/root/go  
ENV PATH=$PATH:$GOPATH/bin  
  
WORKDIR /workspace  
  
ENTRYPOINT ["/usr/bin/go"]  
  


FROM centos:7
MAINTAINER “Bassem Reda Zohdy” <bassem.zohdy@gmail.com>
ENV releasever 7
RUN printf "[mongodb-org-3.0]\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.0/x86_64/\ngpgcheck=0\nenabled=1" >/etc/yum.repos.d/mongodb-org-3.0.repo
RUN yum install -y epel-release
RUN yum -y update; yum clean all
RUN yum install -y mongodb-org
RUN yum install -y nodejs npm
RUN yum install -y git
RUN yum install -y bzip2
RUN yum clean all
RUN git clone https://github.com/bassemZohdy/SimpleCMS.git
RUN mkdir -p /data/db
RUN npm install -g bower
RUN npm install -g grunt-cli
WORKDIR /SimpleCMS/RestService
RUN npm install
WORKDIR /SimpleCMS/WebApp
RUN npm install
RUN bower install --allow-root
WORKDIR /SimpleCMS
EXPOSE 9000:9000

#FROM demoregistry.dataman-inc.com:5000/shurenyun/centos7-base:20160504103437
FROM centos7/base:20160504
MAINTAINER upccup yyao@dataman-inc.com

#install curl
RUN yum -y install \
               curl && \

#add dataman repo
curl -o /etc/yum.repos.d/dupccup.repo http://10.3.10.42/repos/CentOS/7/0/upccup.repo


#install mesos-base
RUN yum install -y mesos-0.25.1 &&  yum clean all

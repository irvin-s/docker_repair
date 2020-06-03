FROM centos:centos6

RUN \
  curl -L -o /etc/yum.repos.d/epel-apache-maven.repo http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo && \
  yum install -y apache-maven java-1.7.0-openjdk-devel which

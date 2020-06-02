FROM centos7/mesos-0.23.0-base  
# centos7/mesos-0.23.0-base is our private mesos image
MAINTAINER prometheus zpang@dataman-inc.com

# jenkins_home
ENV  JENKINS_HOME /var/lib/jenkins

# install
RUN  yum install -y wget git && \
     yum install -y epel-release && \
# install jdk
     yum install -y java-1.8.0-openjdk && \
# install jenkins
     wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo && \
     rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key && \
     yum install -y jenkins && \
     yum clean all

# create mesos logs documents
RUN  mkdir -p /mnt/mesos/sanbox && \
# create mesos documents
     mkdir -p /var/lib/jenkins/

# docker use lib
COPY libdevmapper.so.1.02.1 /lib64/
COPY libapparmor.so.1 /lib64/
RUN ln -s /lib64/libdevmapper.so.1.02.1 /lib64/libdevmapper.so.1.02

FROM openshift/jenkins-slave-base-centos7  
  
MAINTAINER Devin Matte <matted@csh.rit.edu>  
  
ENV LC_ALL=en_US.UTF-8  
  
RUN yum -y install texlive texlive-titlesec make  
  
RUN chown -R 1001:0 $HOME && \  
chmod -R g+rw $HOME  
  
USER 1001  


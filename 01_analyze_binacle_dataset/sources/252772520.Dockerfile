FROM openshift/jenkins-1-centos7  
  
MAINTAINER Ari LiVigni <ari@redhat.com>  
  
# Install 'git' binary needed for the Github plugin  
USER root  
RUN yum install -y git epel-release sudo && yum clean all  
RUN yum install -y python-pip && yum clean all  
RUN pip install jenkins-job-builder==1.1.0  
  
# Setup Jenkins for sudo  
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers  
  
# Install the Jenkins plugin listed in 'plugins.txt'  
COPY plugins.txt /opt/openshift/configuration/plugins.txt  
RUN /usr/local/bin/plugins.sh /opt/openshift/configuration/plugins.txt  
  
# Cleanup the example job and copy new jobs  
#RUN rm -rf /opt/openshift/configuration/jobs/*  
#COPY jobs/* /opt/openshift/configuration/jobs/  
RUN chmod go+rw -R /opt/openshift  
USER 1001  
  


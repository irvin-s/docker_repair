FROM scratch  
MAINTAINER https://bitbucket.org/DigitalBaxter/blockos  
ADD centos-7-docker.tar.xz /  
COPY nodesource-release-el7-1.noarch.rpm /tmp/  
  
LABEL name="BlockOS Base Image" \  
vendor="BlockOS" \  
license="GPLv2" \  
build-date="20161027"  
  
RUN rpm -i /tmp/nodesource-release-el7-1.noarch.rpm  
RUN yum -y update && yum -y install nodejs npm  
  
RUN rm -rf /tmp/nodesource-release-el7-1.noarch.rpm  
  
RUN npm -g install sails  
  
CMD ["/bin/bash"]  


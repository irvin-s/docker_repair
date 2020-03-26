FROM centos  
  
MAINTAINER Daniel Hess <dan9186@gmail.com>  
  
# Install system packages  
RUN yum -y update && \  
yum -y upgrade && \  
yum install -y postgresql-devel sudo tar && \  
yum clean all  
  
# Install RVM  
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && \  
curl -sSL https://get.rvm.io | bash -s stable --ruby=1.9.3  
  
# Create cucumber user  
RUN adduser -r -m cucumber && \  
groupadd sudo && \  
usermod -G sudo cucumber && \  
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \  
chown -R cucumber:cucumber /usr/local/rvm  
  
ENV LANG=en_US.UTF-8 \  
LANGUAGE=en_US.UTF-8 \  
LC_ALL=en_US.UTF-8  
# Add entry script  
ADD docker-entry-point.sh docker-entry-point.sh  
  
ENTRYPOINT ["/docker-entry-point.sh"]  


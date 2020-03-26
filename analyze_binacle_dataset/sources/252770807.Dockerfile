FROM ubuntu:trusty  
  
RUN apt-get update && \  
apt-get install -y software-properties-common && \  
add-apt-repository ppa:git-core/ppa && \  
apt-get update && \  
apt-get install -y ruby ruby-dev sudo build-essential git curl && \  
gem install bundler && \  
  
useradd -u 1000 jenkins && \  
mkdir -p /home/jenkins && \  
chown -R jenkins:jenkins /home/jenkins && \  
adduser jenkins sudo && \  
echo 'jenkins ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers  
  
ADD Gemfile /usr/src/docs/Gemfile  
  
WORKDIR /usr/src/docs  
  
RUN bundle install  


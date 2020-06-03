FROM ubuntu:14.04  
MAINTAINER Erik Osterman "e@osterman.com"  
USER root  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV AWS_ACCESS_KEY_ID foobar_aws_key_id  
ENV AWS_SECRET_ACCESS_KEY foobar_aws_access_key  
  
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup && \  
apt-get update && \  
apt-get -y install software-properties-common && \  
add-apt-repository ppa:duplicity-team/ppa && \  
apt-get update && \  
apt-get -y install duplicity ntpdate python-boto inotify-tools && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
ADD sync.sh /sync.sh  
  
ENTRYPOINT ["/bin/bash", "/sync.sh"]  
  


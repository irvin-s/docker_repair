FROM aurorasystem/base-server  
MAINTAINER Aurora System <it@aurora-system.com>  
  
# Install Node  
RUN \  
curl --silent --location https://rpm.nodesource.com/setup_6.x | bash - && \  
yum -y install bzip2 nodejs && \  
yum clean all  
  
# Use deploy user  
RUN useradd -ms /bin/bash deploy  
USER deploy  
  
# create work dir  
RUN mkdir -p /home/deploy/app  
  
# Set work dir  
WORKDIR /home/deploy/app  


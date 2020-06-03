FROM aurorasystem/server:latest  
MAINTAINER Aurora System <it@aurora-system.com>  
  
RUN \  
curl -sL https://rpm.nodesource.com/setup | bash - && \  
yum -y install bzip2 nodejs && \  
yum clean all && \  
npm install -g phantomjs  
  
  


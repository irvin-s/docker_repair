FROM gitlab/dind  
  
MAINTAINER Shawn Seymour <shawn@devshawn.com>  
  
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -  
RUN apt-get install -y nodejs  
  
RUN mkdir /opt/yarn  
RUN wget https://yarnpkg.com/latest.tar.gz -O /tmp/yarn.tar.gz && \  
tar zvxf /tmp/yarn.tar.gz --strip-components=1 -C /opt/yarn && \  
ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn  


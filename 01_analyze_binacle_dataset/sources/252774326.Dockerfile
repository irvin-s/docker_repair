# Install CentOS 7  
FROM centos:centos7  
  
MAINTAINER Jacob Sachs <jacob@amida-tech.com>  
  
# Enable Extra Packages for Enterprise Linux (EPEL) for CentOS  
# Install additional tools  
RUN yum install -y \  
epel-release \  
git \  
make  
  
# Install Node and NPM  
RUN git clone https://github.com/creationix/nvm.git /.nvm && \  
echo ". /.nvm/nvm.sh" >> /etc/bash.bashrc  
  
ENV NODE_VERSION 0.12.2  
RUN . /.nvm/nvm.sh && \  
nvm install $NODE_VERSION && \  
nvm use $NODE_VERSION && \  
nvm alias default $NODE_VERSION  
  
RUN ln -s /.nvm/versions/node/v$NODE_VERSION/bin/node /usr/bin/node && \  
ln -s /.nvm/versions/node/v$NODE_VERSION/bin/npm /usr/bin/npm  
  
# Install Grunt  
RUN npm install -g grunt-cli  
  
# Install app dependencies  
COPY package.json /src/package.json  
RUN cd /src && npm install  
  
# Bundle app source code  
COPY . /src  
  
# Expose bound port  
EXPOSE 3000  
# Run the app  
WORKDIR "/src"  
CMD ["node", "server.js"]  
  


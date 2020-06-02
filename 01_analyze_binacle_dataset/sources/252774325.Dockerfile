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
  
# Install Ruby and associated tools  
RUN yum install -y ruby && \  
yum install -y gcc ruby-devel rubygems  
  
# Install Compass  
RUN gem update --system && \  
gem install compass; exit 0  
  
# Install Bower and Grunt  
RUN npm install -g \  
bower \  
grunt-cli  
  
# Install app dependencies  
COPY package.json /src/package.json  
COPY bower.json /src/bower.json  
WORKDIR "/src"  
RUN echo '{ "allow_root": true }' > /root/.bowerrc && \  
npm install && \  
bower install  
  
# Bundle app source code  
COPY . /src  
  
# Fix imagemin issue  
RUN npm update -g npm && \  
npm install grunt-contrib-imagemin  
  
# Build the dist  
RUN grunt ngconstant:docker && \  
grunt build  
  
# Expose bound port  
EXPOSE 9000  
# Run the app  
CMD ["grunt", "serve:docker"]  
  


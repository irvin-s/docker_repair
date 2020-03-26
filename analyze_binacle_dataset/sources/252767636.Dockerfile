FROM jenkins:1.609.3  
USER root  
RUN apt-get update && \  
apt-get install -y openssl ruby bundler && \  
apt-get install -y python-setuptools nodejs npm && \  
easy_install pip && \  
pip install awscli awsebcli && \  
update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 && \  
npm install -g npm && \  
npm install -g grunt-cli karma bower phantomjs  
ENV PHANTOMJS_BIN /usr/local/bin/phantomjs  
COPY active.txt .  
RUN /usr/local/bin/plugins.sh active.txt  


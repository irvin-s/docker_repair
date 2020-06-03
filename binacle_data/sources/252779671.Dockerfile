FROM golang:1.6  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \  
apt-get install -y nodejs python-setuptools && \  
npm install -g yarn && \  
easy_install awscli && \  
go get -v github.com/spf13/hugo  


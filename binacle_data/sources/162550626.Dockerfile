FROM mozillamarketplace/centos-python27-mkt:latest

RUN yum install -y npm

RUN npm install -g grunt-cli

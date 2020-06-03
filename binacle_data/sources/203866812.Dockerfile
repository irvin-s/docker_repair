#
# Widestage: Lightweight Business Intelligence tool
#
# https://github.com/bigcontainer/bigcont
#

# Pull base image
FROM centos:7

#FROM node:6.2.2

# Build-time vars
ARG WIDESTAGE_VERSION=1e83e109fa4645b10fe8b43e01ab53239bb38529

RUN git config --global url."https://".insteadOf git://
RUN npm install -g bower

# Widestage installation
RUN \
  yum install epel-release git make npm nodejs -y 

# yum install epel-release git make which nodejs -y 
# cd /opt/widestage
# git clone https://github.com/widestage/widestage.git
# git branch docker-tested $WIDESTAGE_VERSION
# git checkout docker-tested 
# curl -L https://npmjs.org/install.sh | sh
# npm install -g bower
#  npm install express
#  npm install mongoose passport
# bower install --allow-root
# yum install mongodb -y


WORKDIR /opt/widestage/

COPY package.json /opt/widestage/

COPY bower.json /opt/widestage/

RUN npm install

RUN bower install --allow-root --force-latest

COPY . /opt/widestage/

ENTRYPOINT ["node"]

CMD ["server.js"]

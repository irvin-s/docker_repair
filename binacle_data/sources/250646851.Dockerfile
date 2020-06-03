FROM    centos:centos6
RUN     yum install -y epel-release
RUN     yum install -y nodejs npm
VOLUME /src
ADD package.json /src/package.json
WORKDIR /src
ADD package.json package.json
RUN npm install
RUN npm install -g node-inspector
EXPOSE 3001
EXPOSE 8080
CMD ["node-debug","./bin/www"]
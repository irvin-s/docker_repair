# Yeoman with some generators and prerequisites
FROM cthulhu666/yeoman:1.6.0

MAINTAINER Jakub Głuszecki <jakub.gluszecki@gmail.com>

RUN sudo npm install -g --silent grunt-cli@0.1.13 \
    generator-webapp@1.1.0 generator-angular@0.14.0


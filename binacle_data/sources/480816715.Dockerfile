# Yeoman with some generators and prerequisites
FROM cthulhu666/yeoman:1.7.0

MAINTAINER Jakub Głuszecki <jakub.gluszecki@gmail.com>

RUN sudo npm install -g --silent gulp@3.9.1 \
    generator-gulp-webapp@1.1.1 generator-gulp-angular@1.0.2


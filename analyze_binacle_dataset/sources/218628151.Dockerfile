FROM    centos:7
RUN     yum -y update && yum -y upgrade && yum -y groupinstall "Development Tools" && yum -y install dos2unix
RUN     curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - && yum -y install nodejs
RUN     yum -y install libjpeg-turbo-devel libpng-devel giflib-devel && npm i -g node-gyp
RUN     yum -y install epel-release librsvg2-tools rsvg-convert

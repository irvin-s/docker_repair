#
FROM centos:centos6
MAINTAINER xiaocai <miss339742811@163.com>

#RUN curl https://git.oschina.net/feedao/Docker_shell/raw/start/ali-centos.sh | sh

RUN echo 'install environment'
RUN yum -y install tar wget gcc gcc-c++ libxml2-devel zlib-devel bzip2-devel curl-devel libjpeg-devel libpng-devel libtiff-devel freetype-devel openssl openssl-devel vim
RUN yum -y install ncurses-devel cmake

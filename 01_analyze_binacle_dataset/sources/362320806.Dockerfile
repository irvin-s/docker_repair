FROM ubuntu:14.04
MAINTAINER Li XiaoDong

RUN apt-get update

# To compile and install native addons from npm
RUN sudo apt-get install -y build-essential

# install nodejs
# nodejs 6.X
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
# nodejs 7.X
# RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -

RUN sudo apt-get install -y nodejs

# install git
RUN sudo apt-get install -y git

# install zeromq
RUN sudo apt-get install wget -yq
RUN sudo apt-get install libtool pkg-config build-essential autoconf automake -yq
RUN sudo apt-get install python -yq
RUN sudo apt-get install libzmq3-dev
RUN sudo npm i zmq -g

# install redis and start
RUN sudo apt-get install -y redis-server
RUN sudo /etc/init.d/redis-server start

# install mongodb and start
RUN sudo apt-get install -y mongodb
RUN sudo /etc/init.d/mongod start

# set cnpm
RUN npm install -g cnpm --registry=https://r.cnpmjs.org

# 修改时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install pomelo
RUN sudo npm i pomelo -g 







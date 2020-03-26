FROM ubuntu:14.04

MAINTAINER VOID001<zhangjianqiu13@gmail.com>

RUN apt-get update
RUN yes | apt-get install python python3 openjdk-7-jre openjdk-7-jdk php5 ruby mysql-server gcc
RUN yes | apt-get install unzip
RUN yes | apt-get install g++
RUN echo > judgehost-info.txt << EOF Judgehost Image Status \
Python2 Version: $(python2.7 --version) \
Python3 Version: $(python3 --version) \
Java Version: $(java -version) \
PHP Version :$(php --version) \
Ruby Version: $(ruby --version) \
MySQL Version $(mysqld --version) \
gcc version $(gcc --version) \
EOF

RUN service mysql start


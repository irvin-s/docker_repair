# Docker image of disconf consumer
# VERSION 0.0.1
# Author: bolingcavalry

#基础镜像使用tomcat:7.0.77-jre8
FROM tomcat:7.0.77-jre8

#作者
MAINTAINER BolingCavalry <zq2599@gmail.com>

#定义工作目录
ENV WORK_PATH /usr/local/work

#创建工作文件夹
RUN mkdir -p $WORK_PATH

#复制应用包到工作文件夹
COPY ./starter-run $WORK_PATH/
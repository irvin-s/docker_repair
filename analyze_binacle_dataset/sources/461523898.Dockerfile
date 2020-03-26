# Docker image of disconf tomcat
# VERSION 0.0.1
# Author: bolingcavalry

#基础镜像使用tomcat:7.0.77-jre8
FROM tomcat:7.0.77-jre8

#作者
MAINTAINER BolingCavalry <zq2599@gmail.com>

#定义工作目录
ENV TOMCAT_BASE /usr/local/tomcat


#复制配置文件
COPY ./server.xml $TOMCAT_BASE/conf/

#复制war包
COPY ./disconf-web.war $TOMCAT_BASE/webapps/

#给配置文件增加读权限
RUN chmod a+xr $TOMCAT_BASE/conf/server.xml

#删除默认的ROOT文件件
RUN rm -rf $TOMCAT_BASE/webapps/ROOT

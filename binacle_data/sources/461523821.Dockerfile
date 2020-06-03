# Docker image of disconf nginx
# VERSION 0.0.1
# Author: bolingcavalry

#基础镜像使用nginx:stable
FROM nginx:stable

#作者
MAINTAINER BolingCavalry <zq2599@gmail.com>

#定义工作目录
ENV WORK_PATH /usr/local/work/html

#定义nginx配置文件所在目录
ENV NGINX_CONF_DIR /etc/nginx

#定义nginx配置文件名称
ENV NGINX_CONF_FILE_NAME nginx.conf

#创建工作文件夹
RUN mkdir -p $WORK_PATH

#创建nginx日志文件夹
RUN mkdir -p /etc/nginx/logs/

#复制nginx配置文件
COPY ./$NGINX_CONF_FILE_NAME $NGINX_CONF_DIR/

#复制网页的静态资源文件
COPY ./html $WORK_PATH/

#给配置文件增加读权限
RUN chmod a+xr $NGINX_CONF_DIR/$NGINX_CONF_FILE_NAME

FROM ubuntu:16.04  
MAINTAINER beginor <beginor@qq.com>  
  
# Use AliYun mirror as apt source;  
COPY sources.list /etc/apt/sources.list  
# Set time zone to Asia/Shanghai;  
# RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  


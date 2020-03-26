#This dockerfile uses the ubuntu image
#VERSION 2-EDITION 1
#Author: wujuguang
#Command format: Instruction[arguments/command]	..
#Base image to use,	this must be set as	the	first line
# FROM ubuntu:14.04
# 国内加速
FROM daocloud.io/ubuntu:18.04

# Maintainer: docker_user <docker_user at email.com> (@docker_user)
MAINTAINER wujuguang wujuguang@126.com

# Commands to update the image
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ trusty main universe" >> /etc/apt/sources.list
RUN apt-get update && apt-get upgrade
RUN apt-get install -y coreutils vim

# Pip安装Python包的依赖项
RUN apt-get install -y libmysqlclient-dev libxslt1-dev python-dev python-pip
RUN apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/kylin/Luntan/discuzx-tools
ADD ./requirements /home/kylin
ADD media/install-avbin-linux-x86-64-v10 /home/kylin

# 安装mp3支持包
RUN sh /home/kylin/install-avbin-linux-x86-64-v10
RUN pip install -r /home/kylin/requirements/requirement.txt

WORKDIR /home/kylin

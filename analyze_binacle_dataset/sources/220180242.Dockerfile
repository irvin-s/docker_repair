FROM ubuntu:14.04
MAINTAINER yourname
ENV REFRESHED_AT 2018-01-01 
ENV LANG C.UTF-8
RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//http:\/\/mirrors.163.com\/ubuntu\//g' /etc/apt/sources.list
RUN apt-get update -y
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install mysql-server 
RUN apt-get -yqq install apache2 python3 python3-pip
RUN pip3 install flask gunicorn

#RUN sed -i 's/Options Indexes FollowSymLinks/Options None/' /etc/apache2/apache2.conf

 

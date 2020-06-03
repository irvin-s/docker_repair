FROM golang:1.3.1-onbuild  
MAINTAINER Wang Hao <wanghao@directivegames.com>  
ADD aws-config.json /etc/  
EXPOSE 8080


FROM alpine:latest
MAINTAINER niuyuxian <"ncc0706@gmail.com">

ENV TZ=Asia/Shanghai

# 国内镜像
RUN echo -e "https://mirror.tuna.tsinghua.edu.cn/alpine/latest-stable/main\n" > /etc/apk/repositories

RUN apk --update add tzdata vim \
	&& cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \ 	
	&& rm -rf /var/cache/apk/* /tmp/*

FROM registry.cn-hangzhou.aliyuncs.com/dailybird/docker-console:0.0.1

MAINTAINER dailybird <dailybirdo@gmail.com>

# 具体更改可参见 https://github.com/dailybird/docker-console-dockerfile/blob/master/Dockerfile

# 设置 Git 的身份
RUN git config --global user.name "dailybird" \
	&& git config --global user.email "dailybirdo@gmail.com"

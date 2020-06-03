# 使用ubuntu 16.04作为基础镜像
FROM ubuntu:16.04


# 添加一些描述的label，可选
LABEL description="nodejs linux platform environment" version=1.0 author=cd

# 设置一些环境变量
# ENV WORKDIR /opt
# ENV NVM_DIR ~/.nvm

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.10.3

ARG WORKDIR=/home
# 设置一些参数，可以在编译时传入
ARG NPM_REGISTRY=https://registry.npm.taobao.org 
# github 相关资料
ARG GITHUB_NAME=yangchongduo
ARG GITHUB_EMAIL=yangchongduo@gmail.com

# 设置运行用户
USER root

#RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# 执行内容脚本
RUN                                                                                \
    # 众所周知的原因，需要替换ubuntu镜像为163国内镜像，提升apt-get的安装速度与成功率    
    # sed -i 's/security.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list         \
    # sed -i 's/archive.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list       \
    sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list       \
    # apt-get 安装一些软件
    && apt-get update                                                              \    
    && apt-get install -y apt-utils                                                \
    && apt-get install -y sudo                                                     \
     # curl
    && apt-get install -y curl                                                     \
    # 镜像快
    # && curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://ef017c13.m.daocloud.io \
    # && sudo apt-get install -y build-essential libssl-dev                          \
    # && apt-get update                                                              \
    # && apt-get upgrade -y                                                          \
    # # 安装并配置git
    && apt-get install -y git                                                      \
    && git config --global user.email ${GITHUB_EMAIL}                              \
    && git config --global user.name ${GITHUB_NAME}                                \
    && git config --global alias.ci commit -am \
    && git config --global alias.dc  diff --changed \
    && git config --global alias.ds  diff --staged \
    && git config --global alias.co  checkout \
    && git config --global alias.br  branch \ 
    && git config --global alias.ps  push origin  \
    && git config --global alias.pl  pull origin \
    && git config --global alias.sh  stash \
    && git config --global alias.df  diff \
    && git config --global alias.cl  clone\
    # vim
    && sudo apt-get install -y vim                                                 \
    # 自动补全命令
    # && sudo apt-get install bash-completion                                         \
    # yarn ok
    && apt-get install -y  apt-transport-https \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn \
    # nvm ok
    && curl https://raw.githubusercontent.com/creationix/nvm/v0.24.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install v$NODE_VERSION \
    && nvm use v$NODE_VERSION \
    && nvm alias default v$NODE_VERSION \
    && npm config set registry ${NPM_REGISTRY}\
    && apt-get -y clean

# 工作文件件

# 声明数据卷 日志
# VOLUME ${WORKDIR}
# 对外开放端口 多个
EXPOSE 8080
EXPOSE 443
EXPOSE 3000
EXPOSE 8000

# 进入时执行的命令
ENTRYPOINT ["/bin/bash"]
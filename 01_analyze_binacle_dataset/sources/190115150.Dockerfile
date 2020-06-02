
###########
#
# Development Image Build File
#
# Usage:
#
#   docker run -it -v <project-resource-directory>:/workspace \
#                  --name <container-name> [image-name]
#


FROM centos
MAINTAINER ijse

RUN yum -y update
RUN yum -y install tar git

# 配置环境变量
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 0.10.32
ENV WORK_DIR /workspace

# 下载和配置Node.js环境
# 这些命令一定要写在一起, 否则`nvm`命令会找不到
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.24.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install v$NODE_VERSION \
    && nvm use v$NODE_VERSION \
    && nvm alias default v$NODE_VERSION

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

# 设置工作目录
WORKDIR $WORK_DIR

# 公开镜像的80端口
EXPOSE 80

CMD bash

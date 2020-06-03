# 使用DaoCloud的Ubuntu镜像
FROM daocloud.io/library/ubuntu:14.04

# 设置时区
RUN sudo sh -c "echo 'Asia/Shanghai' > /etc/timezone" && \
    sudo dpkg-reconfigure -f noninteractive tzdata

# 使用阿里云的Ubuntu镜像
RUN echo '\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse\n\
deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse\n'\
> /etc/apt/sources.list

# 安装 wget curl
RUN sudo apt-get update && sudo apt-get install -y wget && sudo apt-get install -y curl


# 使用淘宝镜像安装Node.js v6.10.1
RUN wget https://npm.taobao.org/mirrors/node/v8.6.0/node-v8.6.0-linux-x64.tar.gz && \
    tar -C /usr/local --strip-components 1 -xzf node-v8.6.0-linux-x64.tar.gz && \
    rm node-v8.6.0-linux-x64.tar.gz

WORKDIR /data/jsmonitor-fe

# 安装cnpm
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

# 安装项目 npm 包
ADD package.json /data/jsmonitor-fe/package.json
RUN cnpm install

# 添加源代码
ADD . /data/jsmonitor-fe

# 运行
CMD sh run.sh
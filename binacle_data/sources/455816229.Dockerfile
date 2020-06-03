FROM coolq/wine-coolq
MAINTAINER Waylon Wang <waylon.act@gmail.com>

# 安装vim、ifconfig、ping
RUN apt-get update \
    && apt-get install -y vim \
    && apt-get install -y net-tools \
    && apt-get install -y iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# 替换vncmain.sh
WORKDIR /app
COPY ./vncmain.sh vncmain.sh
RUN chmod 777 vncmain.sh

# 更改CoolQ的app配置
WORKDIR /home/user/coolq/conf
COPY ./conf/CQP.cfg CQP.cfg

# 下载coolq-http-api插件
WORKDIR /home/user/coolq/app
ADD https://github.com/richardchien/coolq-http-api/releases/download/v2.1.0/io.github.richardchien.coolqhttpapi.cpk io.github.richardchien.coolqhttpapi.cpk
RUN mkdir -p io.github.richardchien.coolqhttpapi

# 更改coolq-http-api插件的配置
WORKDIR /home/user/coolq/app/io.github.richardchien.coolqhttpapi
COPY ./app/io.github.richardchien.coolqhttpapi/config.cfg config.cfg

WORKDIR /
EXPOSE 9000
VOLUME /home/user/coolq/app/io.github.richardchien.coolqhttpapi

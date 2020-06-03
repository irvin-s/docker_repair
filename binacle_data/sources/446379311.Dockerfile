FROM daocloud.io/library/node:6.11.2-alpine

# alpine换源,中科大
RUN cp /etc/apk/repositories /etc/apk/repositories.bak \
	&& echo "http://mirrors.ustc.edu.cn/alpine/v3.4/main/" > /etc/apk/repositories

# 安装必要文件
RUN apk update \
    \
    && apk add -U --no-cache vim \
    bash \
    ca-certificates \
    grep \
    wget \
    unzip

# npm换源,yarn换源,安装cnpm
RUN npm config set registry https://registry.npm.taobao.org \
    && npm install -g cnpm 

# 设置变量
# ================================
ENV GHOST_VERSION 1.8.1
ENV NODE_ENV production

RUN wget -q https://github.com/TryGhost/Ghost/releases/download/${GHOST_VERSION}/Ghost-${GHOST_VERSION}.zip -P /tmp \
    && unzip -q /tmp/Ghost-${GHOST_VERSION}.zip -d /ghost

# 复制必要文件
COPY config.production.json /ghost
COPY config.development.json /ghost
RUN cd /ghost && ls && cnpm install --${NODE_ENV}

# 复制启动文件
COPY run.sh /usr/local/bin
RUN chmod +x /usr/local/bin/run.sh

WORKDIR /ghost
VOLUME /ghost/content
EXPOSE 2368

LABEL description="Ghost-$GHOST_VERSION" \
      maintainer="imlooke <lwx12525@outlook.com>"

ENTRYPOINT ["run.sh"]
CMD ["./usr/local/bin/run.sh"]
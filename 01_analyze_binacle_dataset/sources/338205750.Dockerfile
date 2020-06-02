FROM kkarczmarczyk/node-yarn
FROM keymetrics/pm2:latest-alpine
MAINTAINER : fulln <i@fulln.me>
#创建app目录,保存我们的代码
RUN mkdir -p /usr/src/node

#设置工作目录
WORKDIR /usr/src/node
#复制所有文件到 工作目录。
COPY . /usr/src/node

#RUN yarn   global add pm2   --privileged=true

RUN yarn

CMD ["yarn","dev","&"]


FROM node:latest

#把当前路径下的文件都拷贝到镜像中的 /src 目录
COPY . /src

# 安装需要的 npm 包
RUN cd /src; npm install

# 内部使用 5000 端口
EXPOSE 5000

# 启动项目
CMD ["node", "/src/app.js"]

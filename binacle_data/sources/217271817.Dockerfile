FROM node:latest

MAINTAINER snowdream <yanghui1986527@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN npm install -g yapi-cli --registry https://registry.npm.taobao.org

# replace this with your application's default port
EXPOSE 3000

# run hexo server
CMD ["yapi", "server"]

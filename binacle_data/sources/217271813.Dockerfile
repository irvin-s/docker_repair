FROM node:latest

MAINTAINER snowdream <yanghui1986527@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install hexo
RUN npm install hexo-cli -g

# replace this with your application's default port
EXPOSE 4000

# run hexo server
CMD ["hexo", "server","-i","0.0.0.0"]

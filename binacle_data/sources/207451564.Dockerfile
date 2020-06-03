FROM daocloud.io/eyasliu/node-server:latest

MAINTAINER Eyas<liuyuesongde@163.com>


# clone repo and install dependent
ENV NODE_ENV development
RUN cd /opt \
 && git clone https://github.com/eyasliu/eyasliu.github.io.git \
 && cd eyasliu.github.io \
 && npm install \
 && chmod 755 /opt/eyasliu.github.io/run


# build server
ENV NODE_ENV production
RUN cd /opt/eyasliu.github.io \
 && npm run build:server

EXPOSE 8000

ENTRYPOINT /opt/eyasliu.github.io/run
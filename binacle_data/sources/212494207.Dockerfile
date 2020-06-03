FROM node:8.9.3
MAINTAINER yuxuewen <8586826@qq.com>

RUN echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib " > /etc/apt/sources.list \
    && echo "deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb http://mirrors.163.com/debian/ jessie-backports main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib " >> /etc/apt/sources.list \
    && echo "deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y \
        vim \
        zip \
        unzip \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && yarn config set registry https://registry.npm.taobao.org \
    && npm install -g cnpm --registry=https://registry.npm.taobao.org \
    && cnpm install --save-dev babel-preset-react \
    && cnpm install --save-dev babel-preset-es2015 \
    && cnpm install -g webpack \
    && cnpm install -g less \
    && cnpm install -g pm2


FROM node:8.9.1

ARG registry="https://registry.npmjs.org"

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PHANTOMJS_CDNURL https://npm.taobao.org/mirrors/phantomjs
ENV NODE_ENV=production
#ENV NODE_SASS_PLATFORM alpine

RUN npm config set registry $registry -g
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
#RUN apk add -U tzdata nano git python build-base curl bash file gcc g++ make curl-dev
#RUN apk add xvfb firefox-esr geckodriver

RUN npm i tarantulajs -g --unsafe-perm

WORKDIR /home/node
ENTRYPOINT npm i tarantulajs@latest -g --unsafe-perm && su node -c 'tarantula-dispatch -s "${TARANTULA_SERVER}" -d "${TARANTULA_DOMAIN}" --max-process ${TARANTULA_MAX_PROCESS:-5} --token ${TARANTULA_TOKEN}'

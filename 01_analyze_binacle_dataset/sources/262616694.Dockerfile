FROM node:8.0.0-alpine

ENV CNPMJS_VERSION=2.19.4 \    
    CNPMJS_DIST_DIR=/app/dist \
    CNPMJS_DATA_DIR=/app/data \
    CNPMJS_TAOBAO=https://registry.npm.taobao.org    

RUN mkdir -p ${CNPMJS_DATA_DIR}

RUN \
    sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories && \
    apk add --update ca-certificates wget && \
    update-ca-certificates

RUN \   
    wget -P /tmp https://github.com/cnpm/cnpmjs.org/archive/${CNPMJS_VERSION}.tar.gz && \
    tar xvzf /tmp/${CNPMJS_VERSION}.tar.gz -C /tmp && \
    mv /tmp/cnpmjs.org-${CNPMJS_VERSION} ${CNPMJS_DIST_DIR}

WORKDIR ${CNPMJS_DIST_DIR}

RUN \    
    npm remove sqlite3 --registry=${CNPMJS_TAOBAO} && \
    npm i oss-cnpm --registry=${CNPMJS_TAOBAO}    

EXPOSE 7001/tcp 7002/tcp

CMD node dispatch.js
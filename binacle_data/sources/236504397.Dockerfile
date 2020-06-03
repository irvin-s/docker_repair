FROM mhart/alpine-node:8.9.3

LABEL maintainer="lizheming <i@imnerd.org>" \
  org.label-schema.name="Drone Wechat Notification" \
  org.label-schema.vendor="lizheming" \
  org.label-schema.schema-version="1.2.0"

WORKDIR /wechat
COPY package.json /wechat/package.json
RUN npm install --production --registry=https://registry.npm.taobao.org

COPY index.js /wechat/index.js
COPY plugin.js /wechat/plugin.js
ENTRYPOINT [ "node", "/wechat/index.js" ]
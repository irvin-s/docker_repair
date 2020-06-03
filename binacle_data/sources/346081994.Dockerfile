FROM node:alpine

ENV CLIENT_DIR=/client
ENV NODE_PATH=/usr/local/lib/node_modules
WORKDIR "/jsbuild"

RUN apk update && \
    apk add python3 && \
    rm -rf /var/cache/apk/* && \
    npm config set unsafe-perm true && \
    npm -g install cssnano requirejs postcss@">=6" postcss-cli@latest postcss-import-url postcss-css-variables

ADD ./build_js.sh /jsbuild/build_js.sh
CMD sh build_js.sh

ADD ./build_templates.py /jsbuild/build_templates.py
ADD ./postcss.config.js /config/postcss.config.js

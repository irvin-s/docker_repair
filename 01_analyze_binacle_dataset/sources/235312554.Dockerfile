# Dockerfile optmized for small size
# docker build -t stdind .
# pty64 --base64 -- ./examples/longRunning.js | docker run -a STDIN -a STDOUT -i --rm -p 4000:4000 --name stdind 'stdind'

FROM node:6.9.2-alpine

EXPOSE 4000

WORKDIR /app

ADD . ./

RUN \
apk add --no-cache --virtual mydeps openssl python build-base && \
wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.1.2/dumb-init_1.1.2_amd64 && \
chmod +x /usr/local/bin/dumb-init && \
npm install --loglevel error --global yarn pty64 && \
cd server && yarn && cd .. && yarn && \
pty64 -- yarn run lint && \
pty64 -- yarn run build && \
rm -rf ./node_modules && \
yarn cache clean && \
npm remove --global yarn pty64 && \
apk del mydeps && \
rm -rf /var/cache/apk/* /tmp/* /root/.npm /root/.node-gyp /root/.gnupg

CMD /usr/local/bin/dumb-init -- node ./server/index.js

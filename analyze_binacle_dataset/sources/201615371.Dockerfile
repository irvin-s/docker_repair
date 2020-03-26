# FROM mhart/alpine-node:base
# FROM mhart/alpine-node:base-0.10
FROM mhart/alpine-node:8

WORKDIR /src
ADD . .

# If you have native dependencies, you'll need extra tools
# Install required APKs needed for building, install node modules, fix phantom, then cleanup.
RUN apk add --update git python build-base curl bash && \
  echo "Fixing PhantomJS" && \
  curl -Ls "https://github.com/dustinblackman/phantomized/releases/download/2.1.1/dockerized-phantomjs.tar.gz" | tar xz -C / && \
  echo "Installing node modules" && \
  sed -i '/postinstall/d' package.json && \
  npm install --production && \
  apk del git python build-base curl && \
  rm -Rf /etc/ssl/certs/* && \
  apk add ca-certificates && \
  rm -rf /usr/share/man /tmp/* /var/tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp

# If you had native dependencies you can now remove build tools
# RUN apk del make gcc g++ python && \
#   rm -rf /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp

EXPOSE 80
CMD ["node", "./lib/server.js"]

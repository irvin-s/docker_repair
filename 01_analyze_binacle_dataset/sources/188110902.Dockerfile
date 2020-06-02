FROM mhart/alpine-node
LABEL application=xss-game-puppeteer

ENV CHROME_BIN="/usr/bin/chromium-browser"\
        PUPPETEER_SKIP_CHROMIUM_DOWNLOAD="true"

RUN set -x \
  && apk update \
  && apk upgrade \
  # replacing default repositories with edge ones
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" > /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  \
  # Add the packages
  && apk add --no-cache dumb-init curl make gcc g++ python linux-headers binutils-gold gnupg libstdc++ nss chromium \
  \
  # Do some cleanup
  && apk del --no-cache make gcc g++ python binutils-gold gnupg libstdc++ \
  && rm -rf /usr/include \
  && rm -rf /var/cache/apk/* /root/.node-gyp /usr/share/man /tmp/* \
  && echo


ENV PORT 31337
ENV MONGO_HOST 127.0.0.1
ENV MONGO_PORT 27017
ENV MONGO_DATABASE wh00t
ENV MONGO_USERNAME wh00t
ENV MONGO_PASSWORD superduperpasswordwithsuperprotection
ENV SERVICE_URL webapp:1337
ENV URL http://localhost:1337
ENV CHROME /usr/bin/chromium-browser

WORKDIR /app
RUN apk update

COPY ./wait-for.sh .
RUN chmod +x wait-for.sh

COPY ./package.json ./yarn.lock ./
RUN yarn install --emoji
COPY . ./

EXPOSE 31337

CMD ./wait-for.sh -t 30 $MONGO_HOST:$MONGO_PORT -- \
    ./wait-for.sh -t 30 $SERVICE_URL -- \
    npx yarn start
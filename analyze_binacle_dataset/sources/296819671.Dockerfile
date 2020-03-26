FROM node:10.2.1-slim AS base
LABEL maintainer "palydingnow@gmail.com"

RUN apt-get update && apt-get install -y wget --no-install-recommends \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y $(apt-cache depends google-chrome-unstable | awk '/Depends:/{print$2}') --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge --auto-remove -y curl \
    && rm -rf /src/*.deb

WORKDIR /app
COPY package.json .
COPY package-lock.json .

FROM base AS dependencies
RUN npm set progress=false && npm config set depth 0
RUN npm i --production
RUN wget https://install.goreleaser.com/github.com/tj/node-prune.sh && sh node-prune.sh && ./bin/node-prune

FROM base AS release
WORKDIR /src-app

COPY --from=dependencies /app/node_modules ./node_modules

RUN ["mkdir", "dev-images"]
COPY ./ /src-app

CMD ["npm", "start"]

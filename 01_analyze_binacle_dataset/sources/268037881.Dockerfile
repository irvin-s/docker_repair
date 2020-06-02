FROM node:9

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /gs/server
WORKDIR /gs/server

COPY package.json yarn.lock ./

ENV NODE_ENV=development

RUN yarn

CMD ["yarn", "run", "watch"]

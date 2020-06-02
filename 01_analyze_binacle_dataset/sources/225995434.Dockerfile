FROM node:argon

RUN apt-get update \
  && apt-get install -y libkrb5-dev \
  && npm config set python python2.7 \
  && rm -rf /var/lib/apt/lists/*

COPY ["package.json", "/usr/src/"]

WORKDIR /usr/src

RUN npm i --quiet --unsafe-perm

COPY [".", "/usr/src/"]

ENV NODE_ENV=production

RUN npm run build && npm prune

EXPOSE 3000

CMD ["node", "index.js"]

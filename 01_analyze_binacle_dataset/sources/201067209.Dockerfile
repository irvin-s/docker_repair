FROM node:alpine

ENV HOME=/home/app

WORKDIR ${HOME}

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*

COPY package.json package-lock.json ${HOME}/

RUN npm install --progress=false --quiet

COPY . ${HOME}

EXPOSE 8080

CMD [ "node", "server.js" ]

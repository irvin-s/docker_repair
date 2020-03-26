FROM k8spracticalguide/node:10.11.0

WORKDIR /src/app

COPY package*.json ./

RUN set -x && \
    npm install --production

COPY . .

ENV NODE_ENV production
USER node
EXPOSE 8080
CMD ["npm", "start"]

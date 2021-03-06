FROM node:6.9.5 as app

WORKDIR /app

#wildcard as some files may not be in all repos
COPY package*.json npm-shrink*.json /app/

RUN npm install --quiet

COPY . /app


RUN npm run compile:all

FROM node:6.9.5

COPY --from=app /app /app

WORKDIR /app
USER node

CMD ["node", "--expose-gc", "app.js"]

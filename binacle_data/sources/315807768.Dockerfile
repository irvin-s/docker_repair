FROM node:10 AS dependencies

WORKDIR /usr/src/app

COPY package.json package-lock.json /usr/src/app/

RUN npm ci

ARG SENTRY_DSN

ENV SENTRY_DSN ${SENTRY_DSN}

COPY . /usr/src/app

RUN npm run build

FROM node:10-slim AS release

WORKDIR /usr/src/app

COPY --from=dependencies /usr/src/app .

CMD ["npm", "start"]

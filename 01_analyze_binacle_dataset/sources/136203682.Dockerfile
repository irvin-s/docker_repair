FROM mhart/alpine-node:9.11.1

ENV HOST 0.0.0.0

# Not using
# ARG API_QL_URL=https://api.dtrip.app/graphql
ARG PROD=True
ARG BASE_URL=https://dtrip.app/
ARG SENTRY_DSN

ENV SENTRY_DSN ${SENTRY_DSN}
ENV API_QL_URL ${API_QL_URL}
ENV PROD ${PROD}
ENV BASE_URL ${BASE_URL}

ADD package.json /app/
ADD yarn.lock /app/
WORKDIR /app

RUN yarn install --production

# COPY . .
ADD . /app

RUN yarn run build --production

EXPOSE 3000

FROM node:10.12-alpine AS node

#RUN apk update && apk add libpng-dev
RUN apk update && apk add --no-cache --update make gcc g++ libc-dev libpng-dev automake autoconf libtool

RUN npm install gulp -g

WORKDIR /app

COPY .eslintrc.js aliases.config.js gulpfile.js package.json vue.config.js webpack.mix.js yarn.lock /app/
# RUN npm install && npm prune --production
RUN yarn install
COPY . /app/
RUN yarn cjs && gulp locale_sync && gulp public-image && yarn build

ENV NODE_ENV=production \
    AUTH1_CLIENT_ID="" \
    AUTH1_CLIENT_SCOPE="openid,offline" \
    AUTH1_CLIENT_SECRET="" \
    AUTH1_ISSUER_URL="" \
    CORS_VALID_ORIGINS="" \
    MAILCHIMP_CLIENT_ID="" \
    MAILCHIMP_CLIENT_SECRET="" \
    POST_MESSAGE_TARGET_ORIGIN="" \
    PTAH_API_HOST_URL="" \
    PUBLIC_HOST="" \
    REDIS_HOST="" \
    REDIS_PORT="" \
    ROUTES_PREFIX="" \
    SENTRY_DSN="" \
    SERVER_PORT=80 \
    SESSION_COOKIE_NAME="" \
    SESSION_COOKIE_SIGN_KEY="" \
    SESSION_MAX_AGE=21600 

EXPOSE 80

CMD ["node", "./index.js"]

FROM node:8.0-alpine

# Install dumb-init (https://github.com/Yelp/dumb-init)
RUN apk add --no-cache --virtual .build-deps-dumb-init \
    python \
    python-dev \
    py-pip \
    build-base \
  && pip install dumb-init \
  && apk del .build-deps-dumb-init

# Disable yarn progress bar
RUN yarn config set no-progress true

# Install pm2
RUN yarn global add pm2

# Set the work directory
ARG APP_DIR
RUN mkdir -p ${APP_DIR}
WORKDIR ${APP_DIR}

# Copy our package.json and yarn.lock and install *before* adding our application files
COPY package.json yarn.lock ./
RUN yarn install --pure-lockfile --production

# Copy application files
COPY build ./build/
COPY .env .env.example pm2.json ./

# Runs "dumb-init -- <CMD>"
ENTRYPOINT ["dumb-init", "--"]

CMD ["pm2-docker", "start", "pm2.json"]

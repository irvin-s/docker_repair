# Frontend asset builder
FROM node:8-stretch

ENV NPM_CONFIG_LOGLEVEL=warn

RUN mkdir /app
WORKDIR /app/
COPY package.json yarn.lock /app/

RUN yarn && \
    yarn cache clean && \
    true

COPY ./src/ /app/src/

# RUN npm run build
CMD ["npm", "run", "watch"]

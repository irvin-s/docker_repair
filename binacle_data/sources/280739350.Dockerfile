FROM node:10-alpine

ARG NODE_ENV=production
ARG API_URL=http://api.knit.pk.edu.pl

ENV HOST='0.0.0.0' \
    PORT=3000 \
    NODE_ENV=${NODE_ENV} \
    API_URL=${API_URL}

COPY deploy/healthcheck.js /usr/local/bin/healthcheck
RUN chmod +x /usr/local/bin/healthcheck

WORKDIR /usr/src/app
ENTRYPOINT ["yarn"]
CMD ["start"]

COPY package.json yarn.lock ./
RUN yarn install

COPY . ./
RUN yarn build

HEALTHCHECK --interval=5s --timeout=1s --start-period=1m \
  CMD healthcheck

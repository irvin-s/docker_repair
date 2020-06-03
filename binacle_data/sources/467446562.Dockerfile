FROM basaltinc/docker-node-php-base:latest
ARG NPM_TOKEN
ARG CIRCLE_BUILD_URL
# doing this so the Docker cache gets cleared each time
RUN echo "CIRCLE_BUILD_URL: $CIRCLE_BUILD_URL"
RUN echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > ~/.npmrc
WORKDIR /app
RUN npx create-knapsack@latest my-site && cd my-site && npm install && npm run build
# COPY . .
EXPOSE 3999
# RUN npm install
# RUN npm run build

CMD cd my-site && npm run serve

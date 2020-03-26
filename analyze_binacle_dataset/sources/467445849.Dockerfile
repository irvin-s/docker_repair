FROM basaltinc/docker-node-php-base:latest
WORKDIR /app
COPY . .
EXPOSE 3999
RUN yarn install && NODE_ENV=production yarn build:pkgs && NODE_ENV=production yarn build:knapsack

CMD echo "the example is: $EXAMPLE" && cd examples/$EXAMPLE && NODE_ENV=production yarn build && NODE_ENV=production yarn serve

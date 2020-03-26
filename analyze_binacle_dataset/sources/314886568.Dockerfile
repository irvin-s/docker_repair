FROM mhart/alpine-node:8.9.4

WORKDIR /usr/app
COPY ./ /usr/app

# Install dev dependencies to remove flow types and process files but after that
# only preserve production ones
RUN cd /usr/app && npm install && npm run flow-remove-types &&  npm prune --production

WORKDIR /usr/app

CMD ["node", "./flow-files/index.js"]


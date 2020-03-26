FROM node:alpine
WORKDIR /test
COPY package.json .babelrc /test/
RUN npm install
CMD ["node_modules/.bin/mocha", \
     "--compilers", "babel-core/register", \
     "--colors", \
     "index.js"]

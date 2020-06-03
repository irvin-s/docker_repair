FROM node:alpine
WORKDIR /app
COPY package.json .babelrc /app/
RUN npm install
COPY index.js /app/index.js
CMD ["node_modules/.bin/babel-node", "index.js"]

FROM node:alpine

WORKDIR /usr/app/
COPY yarn.lock package.json ./
RUN yarn
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]

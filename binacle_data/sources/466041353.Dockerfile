FROM node
WORKDIR /usr/app
COPY package.json ./
RUN npm i
COPY . .
RUN npm run build

# stage 2
FROM node
WORKDIR /usr/app
COPY package.json ./
RUN npm i --production
COPY --from=0 /usr/app/dist .

ENV NODE_ENV=production
EXPOSE 4000
CMD node src/scripts/add-data.js && node src/index.js
USER node
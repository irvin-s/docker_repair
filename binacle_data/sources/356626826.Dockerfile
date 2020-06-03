FROM node:5.9.0

WORKDIR /tmp
COPY package.json /tmp/
RUN npm config set registry http://registry.npmjs.org/ && npm install -q --production

WORKDIR /usr/src/app
COPY . /usr/src/app/
RUN cp -a /tmp/node_modules /usr/src/app/
RUN npm run build-server
RUN npm run build-webpack

ENV NODE_ENV=production 
ENV PORT=8080

CMD [ "/usr/local/bin/npm", "run", "start" ]

EXPOSE 8080

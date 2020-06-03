FROM bitnami/node:7.5.0-r0

COPY . /app

RUN npm install --production

EXPOSE 8080
CMD ["node", "server.js"]

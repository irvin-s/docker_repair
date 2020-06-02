FROM mhart/alpine-node:11.12

WORKDIR /src
COPY . .
COPY .exemplo_env .env
RUN npm install

EXPOSE  8001
CMD ["node", "index.js"]

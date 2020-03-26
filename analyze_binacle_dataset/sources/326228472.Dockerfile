# docker build -t webportal:sj .

FROM node:carbon

WORKDIR /usr/src/app

ENV NODE_ENV=production \
    SERVER_PORT=8080

COPY ./ /usr/src/app/
RUN yarn install
RUN npm run build

EXPOSE ${SERVER_PORT}

CMD ["npm", "start"]

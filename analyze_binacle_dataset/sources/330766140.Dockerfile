FROM node:carbon

WORKDIR /usr/src/app

COPY package*.json ./
RUN [ "npm", "install", "--only=production" ]

EXPOSE 8080

COPY wait-for-it.sh .
RUN [ "chmod", "+x", "wait-for-it.sh" ]

ENTRYPOINT [ "./wait-for-it.sh", "talk-db:3306", "--" ]
CMD [ "npm", "start" ]

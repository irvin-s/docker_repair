FROM node:6

WORKDIR /var/nyt/app

EXPOSE 3000

CMD [ "npm", "start" ]

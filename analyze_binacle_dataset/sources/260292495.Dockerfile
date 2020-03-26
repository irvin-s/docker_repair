FROM node:6.10.3

WORKDIR /serverless-app

ENV PATH $PATH:/serverless-app/node_modules/.bin

CMD ["npm", "test"]

FROM node:8

# Create app directory
WORKDIR /usr/src/app

#ENV NODE_ENV=production
# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY *.lock package*.json ./

RUN yarn install

COPY . .

EXPOSE 8080
CMD [ "npm", "start" ]

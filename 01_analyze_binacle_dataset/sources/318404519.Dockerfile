FROM node:lts-alpine



# Create app directory
WORKDIR /usr/src/app

RUN mkdir var
RUN mkdir var/log

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package.json .
COPY yarn.lock .

COPY . .

RUN yarn install
RUN yarn global add nodemon
# If you are building your code for production
# RUN npm ci --only=production

CMD [ "yarn", "start" ]

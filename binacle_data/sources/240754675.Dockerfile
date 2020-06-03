FROM node:carbon

# Create app directory
RUN mkdir -p /usr/koa-user/backend/src
RUN mkdir -p /usr/koa-user/frontend/src
RUN mkdir -p /usr/koa-user/files
RUN mkdir -p /usr/koa-user/logs

WORKDIR /usr/koa-user/backend/src




# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY ./backend/src/package*.json /usr/koa-user/backend/src/

ENV PUPPETEER_DOWNLOAD_HOST https://storage.googleapis.com.cnpmjs.org
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV NODE_PATH /usr/koa-user/backend/src

RUN cd /usr/koa-user/backend/src
RUN npm install
# If you are building your code for production
# RUN npm install --only=production




# Bundle app source
COPY ./backend/src /usr/koa-user/backend/src/
COPY ./frontend/src /usr/koa-user/frontend/src/




EXPOSE 3000

CMD [ "npm", "start" ]


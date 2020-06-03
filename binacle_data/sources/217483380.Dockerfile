FROM node:slim
MAINTAINER George Diaz

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN npm install -g webpack

ADD package.json $APP_HOME/

ENV NODE_ENV=production \
  PATH=$APP_HOME/node_modules/.bin:$PATH

RUN npm install

ADD . $APP_HOME

# Write the bundle.js static asset file
RUN npm run build

# Boot the server
CMD ["npm", "start"]

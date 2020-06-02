FROM node:8.11.2
ENV NPM_CONFIG_LOGLEVEL warn
COPY . /app
WORKDIR /app
RUN ["npm", "install", "-g", "karma-cli"]
RUN ["npm", "install", "-g", "bower"]
RUN ["npm", "install", "-g", "gulp-cli"]
RUN ["npm", "install"]
WORKDIR /app/src
RUN ["npm", "install"]
RUN ["bower", "install", "--allow-root"]
RUN ["gulp", "build"]
WORKDIR /app
RUN ["npm", "test"]

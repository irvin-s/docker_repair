FROM node:8.11.2
ENV NPM_CONFIG_LOGLEVEL warn
COPY . /app
WORKDIR /app
RUN ["npm", "install", "-g", "bower"]
RUN ["npm", "install", "-g", "gulp-cli"]
RUN ["npm", "install"]
RUN ["bower", "install", "--allow-root"]
EXPOSE 1337
CMD ["gulp"]

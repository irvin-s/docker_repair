FROM node:9.4.0-alpine
COPY src/  /src/
COPY package.json .
COPY index.js .
RUN rm -rf node_modules &&\
    npm  install --suppess-warnings &&\
    apk update &&\
    apk upgrade
EXPOSE  9080
CMD node index.js

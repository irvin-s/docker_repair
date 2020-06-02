FROM node:latest

WORKDIR /app
COPY package.json /app/
COPY .gitignore .npmignore /app/
RUN npm i
COPY spec /app/spec
COPY src /app/src
COPY tsconfig.json gulpfile.js /app/
RUN npm run build

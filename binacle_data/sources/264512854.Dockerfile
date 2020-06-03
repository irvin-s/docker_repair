FROM node:8.1-alpine
COPY node_modules /node_modules
COPY dist/*.js /

CMD node /example.js

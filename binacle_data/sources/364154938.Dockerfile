FROM node:4-onbuild
ADD package.json package.json
RUN npm install
ADD . .
ENTRYPOINT ["node","server.js"]
EXPOSE 8080

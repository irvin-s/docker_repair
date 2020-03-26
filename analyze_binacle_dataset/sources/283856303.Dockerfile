FROM node:8.9.1
ADD package.json /srv
ADD web_server /srv/web_server
ADD client /srv/client
WORKDIR /srv
RUN npm i
RUN npm run build
EXPOSE 8080
CMD npm start -- --in-cluster
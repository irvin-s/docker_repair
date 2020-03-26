FROM mhart/alpine-node:latest

RUN mkdir -p /usr/www
COPY . /usr/www
WORKDIR /usr/www
RUN npm install --production

EXPOSE 3000

CMD ["npm", "start"]
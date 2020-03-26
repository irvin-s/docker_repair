from node:8-alpine
COPY . /var/www/html
WORKDIR /var/www/html
RUN npm ci
CMD [ "npm","run","start" ]
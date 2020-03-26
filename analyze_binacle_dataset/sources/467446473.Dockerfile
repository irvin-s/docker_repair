FROM basaltinc/docker-node-php-base:latest
WORKDIR /app
COPY . .
EXPOSE 3999
RUN npm install
RUN npm run build
RUN npm run test

CMD npm run serve

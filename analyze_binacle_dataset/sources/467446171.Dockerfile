FROM basaltinc/docker-node-php-base:latest
WORKDIR /app
COPY . .
RUN npm install && npm run build
EXPOSE 3999

CMD npm run serve

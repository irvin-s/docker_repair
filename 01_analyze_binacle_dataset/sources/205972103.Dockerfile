FROM node:8.8-alpine
RUN mkdir /app
WORKDIR /app
ADD package.json .
RUN npm install
ADD . .
ENTRYPOINT ["./compose-runMigrations.sh"]
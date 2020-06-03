### build stage ###
FROM node:10.11-alpine as build-stage
WORKDIR /app
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh
# split the package install from the build step
# to cache the installed packages layer
COPY package*.json ./
RUN npm install
# copy the code and build
COPY . .
RUN npm run build

### production stage ###
FROM nginx:1.15.3-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/run_server.sh /run_server.sh
EXPOSE 8080
CMD ["/run_server.sh"]

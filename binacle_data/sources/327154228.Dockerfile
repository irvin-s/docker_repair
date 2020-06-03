##
## Build Stage
##
FROM node:10-alpine as build

WORKDIR /src

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

##
## Production Stage
##
FROM nginx:1.13.12-alpine as production
COPY --from=build /src/dist /usr/share/nginx/html
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
FROM node:10.15.1-alpine as aepp-vue-build
ARG VUE_APP_NODE_URL
ARG VUE_APP_NODE_INTERNAL_URL
WORKDIR /app
RUN apk add make gcc g++ python git
COPY  . .
RUN npm install
RUN VUE_APP_NODE_URL=$VUE_APP_NODE_URL VUE_APP_NODE_INTERNAL_URL=$VUE_APP_NODE_INTERNAL_URL npm run build

FROM nginx:1.13.7-alpine
COPY --from=aepp-vue-build /app/dist /usr/share/nginx/html
COPY LICENSE /usr/share/nginx/html

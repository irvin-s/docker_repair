FROM node:8.16.0-alpine as build-stage
WORKDIR /usr/src/app

# install build dependencies
COPY package.json yarn.lock .yarnrc ./
# install packages offline
COPY npm-packages-offline-cache ./npm-packages-offline-cache
RUN yarn install

# create react app needs src and public directories
COPY src ./src
COPY public ./public

RUN yarn build

FROM nginx:1.15.12-alpine
ENV NGINX_USER=nginx
RUN rm -rf /etc/nginx/conf.d
COPY nginx /etc/nginx
COPY --from=build-stage /usr/src/app/build /usr/share/nginx/html/filing/2018
RUN apk --no-cache add shadow && \
    usermod -l $NGINX_USER nginx && \
    groupmod -n $NGINX_USER nginx && \
    chown -R $NGINX_USER:$NGINX_USER /etc/nginx /usr/share/nginx/html/filing/2018
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
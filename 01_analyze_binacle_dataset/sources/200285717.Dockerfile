FROM nginx:stable-alpine

RUN apk --no-cache add bash ca-certificates

# delete default nginx html
RUN rm -rf /usr/share/nginx/html/*

# copy in pre-built site content
COPY  ./build/ /usr/share/nginx/html/

# configure nginx
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

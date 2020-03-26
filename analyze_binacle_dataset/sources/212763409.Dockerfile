FROM nginx:alpine
RUN apk --no-cache add drill
RUN rm -f /etc/nginx/conf.d/default.conf
ADD nginx.conf /etc/nginx/conf.d/default.conf

FROM nginx:alpine
RUN rm /etc/nginx/conf.d/default.conf
COPY build /usr/share/nginx/html
COPY addons /usr/share/nginx/html/addons
COPY docker/nginx/default.conf /etc/nginx/conf.d/

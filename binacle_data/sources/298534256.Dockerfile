FROM nginx:latest
RUN mkdir -p /data/www/trip/dist
RUN mkdir -p /logs
ADD trip/dist/ /data/www/trip/dist
RUN rm /etc/nginx/conf.d/default.conf
ADD dockerfiles/nginx/nginx.conf /etc/nginx/
EXPOSE 80
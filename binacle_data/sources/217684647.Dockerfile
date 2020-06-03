FROM nginx:latest
COPY nginx.conf /etc/nginx/nginx.conf
COPY ok /usr/share/nginx/www/_ah/start
COPY ok /usr/share/nginx/www/_ah/health
RUN chmod -R a+rx /usr/share/nginx/www
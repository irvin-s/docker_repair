FROM nginx
 
COPY nginx-app.conf /etc/nginx/conf.d/default.conf 
COPY static/worldcities.json /var/www/static/
COPY static/democities.json /var/www/static/
FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY www /usr/share/nginx/html
RUN chown nginx.nginx /usr/share/nginx/html/ -R

FROM nginx

COPY nginx-selfsigned.crt /etc/ssl/
COPY nginx-selfsigned.key /etc/ssl/

COPY index.html /usr/share/nginx/html/
COPY *.png /usr/share/nginx/html/

COPY nginx.conf /etc/nginx

RUN rm /etc/nginx/conf.d/default.conf
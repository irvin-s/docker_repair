FROM nginx:1.9.10

ADD redash.conf /etc/nginx/conf.d/default.conf

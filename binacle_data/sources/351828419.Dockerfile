FROM nginx:1.9

RUN rm /etc/nginx/conf.d/default.conf

ADD default.conf /etc/nginx/conf.d/
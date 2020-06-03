FROM nginx

ADD nginx.conf /etc/nginx/
ADD my_app.conf /etc/nginx/conf.d/default.conf

#ADD letsencrypt.sh ./letsencrypt.sh
#RUN /bin/bash -c "source ./letsencrypt.sh"
RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

EXPOSE 80
EXPOSE 443

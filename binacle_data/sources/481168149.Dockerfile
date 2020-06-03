FROM nginx:latest
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN apt-get update && apt-get install openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=GB/ST=London/L=London/O=NA/CN=localhost"
RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
RUN mkdir /etc/nginx/snippets
COPY self-signed.conf /etc/nginx/snippets/self-signed.conf
COPY ssl-params.conf /etc/nginx/snippets/ssl-params.conf

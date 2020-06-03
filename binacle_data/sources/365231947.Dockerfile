FROM ubuntu:latest

MAINTAINER Dan Wahlin

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.9.4-1~trusty

RUN apt-get update && \
    apt-get install -y ca-certificates nginx=${NGINX_VERSION} && \
    rm -rf /var/lib/apt/lists/*

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME /var/cache/nginx

# Copy custom nginx config
COPY ./config/nginx.conf /etc/nginx/nginx.conf

# Copy self-signing cert: https://devcenter.heroku.com/articles/ssl-certificate-self
COPY ./.certs/server.crt    /etc/nginx/server.crt
COPY ./.certs/server.key    /etc/nginx/server.key

# Copy DHE handshake and dhparam https://bjornjohansen.no/optimizing-https-nginx
COPY ./.certs/dhparam.pem   /etc/nginx/dhparam.pem

# Make cert key only available to owner (root)
RUN chmod 600 /etc/nginx/server.key

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

# To build:
# docker build -f Dockerfile-nginx --tag danwahlin/nginx .

# To run: 
# docker run -d -p 80:6379 --name nginx danwahlin/nginx
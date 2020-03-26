FROM ubuntu:latest

# keep the container updated
RUN apt-get update -qq && apt-get install -y build-essential

# install the latest nginx
RUN apt-get install -y nginx

# Install a customized nginx config
ENV NGINX_CONFIG_HOME /etc/nginx
WORKDIR $NGINX_CONFIG_HOME
COPY nginx.conf $NGINX_CONFIG_HOME

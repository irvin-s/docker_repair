FROM nginx:1.15.9-alpine

LABEL maintainer="Bert Oost <hello@bertoost.com>"

RUN apk add --no-cache bash gawk sed grep bc coreutils \
    && rm -rf /var/cache/apk/*

RUN mkdir /etc/nginx/conf.d/custom

# Copy files where necessary
COPY defaults/nginx.conf /etc/nginx/nginx.conf
COPY defaults/fastcgi_params /etc/nginx/fastcgi_params
COPY defaults/overall_params.conf /etc/nginx/overall_params.conf
COPY defaults/overall_ssl.conf /etc/nginx/overall_ssl.conf
COPY defaults/health_check.conf /etc/nginx/health_check.conf

# Copy default NginX config
COPY conf.d/default.conf /etc/nginx/conf.d/default.placeholder

# Copy entrypoint file and make it executable
COPY build/entrypoint.sh /usr/src/docker-entrypoint.sh
RUN chmod +x /usr/src/docker-entrypoint.sh

EXPOSE 80
EXPOSE 8888

ENTRYPOINT [ "bash", "/usr/src/docker-entrypoint.sh" ]
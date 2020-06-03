FROM alpine:3.4

EXPOSE 8080

# root user will run 'nginx: master process'
# nobody user will run 'nginx: worker process' as dictated in the nginx.non-root.conf
CMD ["nginx", "-g", "daemon off;"]

# Install nginx package and remove cache
RUN apk add --update nginx && rm -rf /var/cache/apk/*

RUN mkdir -p /etc/nginx/sites/ /var/www/
# Copy basic files
COPY tools/nginx.conf /etc/nginx/nginx.conf
COPY output/nginx_*.conf /etc/nginx/sites/
ADD output/bem.info /var/www/bem.info
# -R and trailing slash are mandatory for recursive copy files from "static" dir
RUN find /var/www/bem.info -type d -maxdepth 1 -iname '??' -exec cp -R /var/www/bem.info/static/ {}/ \;

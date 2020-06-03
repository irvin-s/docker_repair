#
FROM nginx:latest
MAINTAINER Grahame Bowland <grahame@oreamnos.com.au>

RUN rm -rf /etc/nginx
COPY nginx /etc/nginx

EXPOSE 80 443

# Somehow this and the docker-compose.yml file was creating a directory structure of
# /[/app]
# VOLUME ['/app']

ENTRYPOINT ["/app/docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]

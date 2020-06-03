# Build a minimal distribution container
FROM alpine:3.3
ENV TERM=xterm
ENV PROJECT_NAME="portus"
ADD https://s3-eu-west-1.amazonaws.com/madecom-alpine-repo/main/ops%40made.com-5677cf76.rsa.pub /etc/apk/keys/abuild.rsa.pub
RUN chmod -R 644 /etc/apk/keys/
RUN echo "@made http://madecom-alpine-repo.s3-website-eu-west-1.amazonaws.com/main" >> /etc/apk/repositories
RUN adduser -S $PROJECT_NAME && addgroup -S $PROJECT_NAME && addgroup $PROJECT_NAME $PROJECT_NAME
RUN apk update && apk add ca-certificates pongo-blender@made gosu@made apache2-utils docker-registry \
    && mkdir -p /etc/pongo-blender/
ADD config.yml.tmpl /etc/pongo-blender/config.yml.tmpl
ADD ssl_crt.crt /etc/docker-registry/ssl_crt.crt
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD tools.sh /sbin/tools
RUN chmod +x /sbin/tools

VOLUME ["/registry_data"]
EXPOSE 5000
CMD /usr/bin/entrypoint.sh
ADD Dockerfile /registry.Dockerfile

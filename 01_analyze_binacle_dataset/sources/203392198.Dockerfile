FROM alpine:3.3
ENV TERM=xterm
ENV PROJECT_NAME="portus"
ADD https://s3-eu-west-1.amazonaws.com/madecom-alpine-repo/main/ops%40made.com-5677cf76.rsa.pub /etc/apk/keys/abuild.rsa.pub
RUN chmod -R 644 /etc/apk/keys/
RUN echo "@made http://madecom-alpine-repo.s3-website-eu-west-1.amazonaws.com/main" >> /etc/apk/repositories
RUN adduser -S $PROJECT_NAME && addgroup -S $PROJECT_NAME && addgroup $PROJECT_NAME $PROJECT_NAME
RUN apk update && apk add nginx ca-certificates pongo-blender@made
ADD nginx.conf.tmpl mime.types site.conf.tmpl /etc/pongo-blender/
ADD ssl_crt.crt ssl_key.key /etc/nginx/
ADD entrypoint.sh /usr/bin/entrypoint.sh
ADD tools.sh /sbin/tools
RUN chmod +x /sbin/tools

CMD entrypoint.sh
EXPOSE 80
EXPOSE 443
ADD Dockerfile /nginx.Dockerfile
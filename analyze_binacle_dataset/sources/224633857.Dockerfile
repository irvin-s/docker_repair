FROM alpine:3.5
MAINTAINER jyliu <jyliu@dataman-inc.colm>

# copy local repos
COPY repositories /etc/apk/

#modify localtime
COPY Shanghai /etc/localtime

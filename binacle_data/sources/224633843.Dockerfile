FROM alpine:3.3

# copy local repos
COPY repositories /etc/apk/

#modify localtime
RUN rm -f /etc/localtime
COPY Shanghai /etc/localtime

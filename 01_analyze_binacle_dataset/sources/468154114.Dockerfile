FROM alpine:latest
WORKDIR /var/www/html
RUN echo $(pwd)
CMD sh bootstrap.sh
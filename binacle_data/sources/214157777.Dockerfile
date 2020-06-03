FROM gliderlabs/alpine:3.1
RUN apk-install nginx apache2-utils
RUN mkdir -p /tmp/nginx/client-body
COPY ./entrypoint /bin/entrypoint
COPY ./nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["/bin/entrypoint"]

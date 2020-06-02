FROM alpine:3.3
RUN apk add --update nginx && rm -rf /var/cache/apk/*
RUN mkdir -p /tmp/nginx/client-body

COPY ./replicated/nginx/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]

FROM nginx:alpine

MAINTAINER yesterday679 <yesterday679@gmail.com>

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk upgrade \
    && apk add --no-cache bash \
    && rm /etc/nginx/nginx.conf \
    && rm /etc/nginx/conf.d/default.conf \
    && sh -c "echo 'Asia/Shanghai' > /etc/timezone"

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

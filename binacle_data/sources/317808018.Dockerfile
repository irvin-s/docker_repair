FROM nginx:latest
ENV TZ=Asia/Shanghai
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./site /usr/share/nginx/html

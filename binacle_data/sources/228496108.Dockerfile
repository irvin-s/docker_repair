FROM xdrum/nginx-extras:stable

RUN apt-get update && apt-get install -y lua5.1 liblua5.1-0 liblua5.1-0-dev

RUN ln -s /usr/lib/x86_64-linux-gnu/liblua5.1.so /usr/lib/liblua.so

COPY nginx.conf /etc/nginx/nginx.conf

COPY prometheus.conf /etc/nginx/conf.d/

ADD https://raw.githubusercontent.com/knyar/nginx-lua-prometheus/master/prometheus.lua /nginx-lua-prometheus/

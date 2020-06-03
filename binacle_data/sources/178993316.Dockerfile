FROM   nginx
RUN    apt-get update && apt-get install -y curl
ADD    ./default.conf /etc/nginx/conf.d/default.conf
ADD    ./nginx.conf /etc/nginx/nginx.conf
VOLUME ["/www"]
CMD    ["/usr/sbin/nginx"]

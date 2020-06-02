FROM centos

# MINIMAL VERSION
# docker build -t redisproxy-resty:centos .
# docker run --name=redisproxy-resty -it -p 8080:8080 -e APP_DIR=/opt/lua/redisproxy-resty -e REDIS_SERVICE_HOST=172.22.33.140 -e REDIS_SERVICE_PORT=6379 redisproxy-resty:centos
# docker exec -it redisproxy-resty /bin/bash
# docker logs -f redisproxy-resty
# docker stop redisproxy-resty
# docker ps -a --no-trunc| grep '\''Exit'\'' | awk '\''{print $1}'\'' | xargs -L 1 -r docker rm'
# docker inspect redisproxy-resty|grep -i logpath | awk -F\" '{print $4}' | xargs sudo tail -f

MAINTAINER Ivan Ribeiro Rocha <ivan.ribeiro@gmail.com>

RUN mkdir -p /opt/lua/redisproxy-resty

COPY repos/OpenResty.repo /etc/yum.repos.d/

RUN yum update -y && yum install -y openresty

WORKDIR /opt/lua/redisproxy-resty

COPY bin /usr/local/bin
COPY dump.lua /opt/lua/redisproxy-resty/
COPY proxy.lua /opt/lua/redisproxy-resty/
COPY nginx.conf /opt/lua/redisproxy-resty/

EXPOSE 8080

CMD [ "openresty", "-c", "/opt/lua/redisproxy-resty/nginx.conf" ]

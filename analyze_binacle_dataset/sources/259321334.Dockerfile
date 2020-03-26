FROM openjdk:8-jre-alpine

RUN apk add --update ttf-dejavu && rm -rf /var/cache/apk/*

ADD build/libs/lxccms.jar .

ENV DB_HOST="127.0.0.1"
ENV DB_PORT="3306"
ENV DB_USERNAME="root"
ENV DB_PASSWD="root"

ENV REDIS_HOST="127.0.0.1"
ENV REDIS_PORT="6379"

ENTRYPOINT exec java -Duser.timezone=Asia/Shanghai -jar /lxccms.jar \
    --spring.profiles.active=product \
    --spring.datasource.url=jdbc:mysql://${DB_HOST}:${DB_PORT}/lxcCMS?useSSL=false \
    --spring.datasource.username=${DB_USERNAME} \
    --spring.datasource.password=${DB_PASSWD} \
    --spring.redis.host=${REDIS_HOST} \
    --spring.redis.port=${REDIS_PORT} \

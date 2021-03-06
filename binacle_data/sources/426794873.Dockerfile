FROM nginx:alpine

LABEL maintainer="abelov@i-novus.ru"

RUN apk add tzdata
ENV TZ=Europe/Moscow

EXPOSE 80

COPY target/META-INF/resources/docs /usr/share/nginx/html
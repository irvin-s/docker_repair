FROM java:openjdk-8-jre
ADD frame-api.jar app.jar
ENV PROFILES dev
#设置时区
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar","--spring.profiles.active=${PROFILES}"]
EXPOSE 8080
FROM java:openjdk-8-jre
ADD frame-eureka-server.jar app.jar
ENV PROFILES dev
#设置时区
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
ENTRYPOINT ["java","-jar","/app.jar","--spring.profiles.active=${PROFILES}"]
EXPOSE 1111
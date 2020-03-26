FROM java:openjdk-8-jre
# 创建数据卷挂载点
ADD frame-config-server.jar app.jar
ENV PROFILES dev
#设置时区
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar","--spring.profiles.active=${PROFILES}"]
EXPOSE 7001
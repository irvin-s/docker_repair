# 基于哪个镜像
FROM java:8
# 将本地文件夹挂载到当前容器
VOLUME /tmp
# 复制文件到容器
ADD eureka-server-docker-0.0.1-SNAPSHOT.jar app.jar
RUN bash -c 'touch /app.jar'
# 声明需要暴露的端口
EXPOSE 91
# 配置容器启动后执行的命令
ENTRYPOINT ["java", "-jar", "/app.jar"]

MAINTAINER Switch<switchvov@163.com>
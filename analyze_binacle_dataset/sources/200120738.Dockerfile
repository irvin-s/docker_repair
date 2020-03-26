#基于哪个镜像
FROM java:8
#将本地文件挂载到当前容器
VOLUME /mydata/tmp
#复制文件到容器
ADD eureka-server-0.0.1-SNAPSHOT.jar /app.jar
#声明需要暴露的端口
EXPOSE 1111
#配置容器启动后执行的命令
ENTRYPOINT ["java","-jar","/app.jar"]

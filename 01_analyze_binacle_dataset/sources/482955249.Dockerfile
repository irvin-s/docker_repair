
FROM openjdk:11
MAINTAINER main@jdkhome.com

# 拷贝可执行程序
COPY build/libs /var/app

# 端口
EXPOSE 8080

CMD ["java", "-jar", "-Dfile.encoding=UTF8", "-Duser.timezone=GMT+08", "-Dfastjson.parser.autoTypeSupport=true", "/var/app/blzo-core.jar"]

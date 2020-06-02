FROM tomcat:9-jre8-alpine
MAINTAINER DoyuTu 859898972@qq.com
#VOLUME /tmp
ARG JAR_FILE
ARG PROJECT_ARTIFACT_ID
ENV APP app.war
# 定义变量、后续会使用 ，具体路径可以先启动容器然后进入进行查看
ENV DIR_WEBAPP /usr/local/tomcat/webapps/
#删除webapp下所有文件
RUN  rm -rf $DIR_WEBAPP/*
COPY ${JAR_FILE} ${CATALINA_HOME}/${APP}
RUN unzip ${CATALINA_HOME}/${APP} -d ${DIR_WEBAPP}/${PROJECT_ARTIFACT_ID}/
EXPOSE 8080
CMD ["catalina.sh", "run"]

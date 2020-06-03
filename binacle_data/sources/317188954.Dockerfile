FROM registry.cn-hangzhou.aliyuncs.com/choerodon-tools/javabase:0.8.0
COPY app.jar /manager-service.jar
CMD java $JAVA_OPTS $SKYWALKING_OPTS -jar /manager-service.jar
FROM registry.cn-hangzhou.aliyuncs.com/choerodon-tools/javabase:0.8.0
COPY app.jar /agile-service.jar
COPY dist /dist
COPY enterpoint.sh /enterpoint.sh
RUN chmod 777 /enterpoint.sh
CMD /enterpoint.sh java $JAVA_OPTS $SKYWALKING_OPTS -jar /agile-service.jar
FROM java:8

RUN mkdir /indigo-iam
WORKDIR /indigo-iam
CMD java $IAM_JAVA_OPTS -jar $IAM_JAR

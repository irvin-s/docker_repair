FROM java:8

RUN mkdir /indigo-iam
WORKDIR /indigo-iam
COPY iam-login-service.war /indigo-iam/
CMD java $IAM_JAVA_OPTS -jar iam-login-service.war

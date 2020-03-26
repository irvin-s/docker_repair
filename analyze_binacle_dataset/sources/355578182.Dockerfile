FROM openjdk:8-jre
LABEL maintainer="tangfeixiong <tangfx128@gmail.com>" \
      project="https://github.com/tangfeixiong/go-to-kubernetes" \
      name="web-console" \
      annotation='{"example.com/console-k8s":"web-console"}' \
      tag="centos java1.8 openjdk springboot"

ARG jarTgt
ARG javaOpt

COPY ${jarTgt:-web-console.jar} /web-console.jar

ENV JAVA_OPTIONS="${javaOpt:-'-Xms128m -Xmx512m -XX:PermSize=128m -XX:MaxPermSize=256m'}" \
    GO_TO_KUBERNETES="console-k8s"

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/web-console.jar"]

FROM openjdk:8-jre-alpine
ADD /target/oauth2-code.jar server.jar
CMD ["/bin/sh","-c","java -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=1 -Dlight-4j-config-dir=/config -Dlogback.configurationFile=/config/logback.xml -Djava.security.krb5.conf=/config/krb5.conf -jar /server.jar"]

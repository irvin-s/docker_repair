FROM openjdk:8-jre-alpine
WORKDIR /root
ENV REDIS_HOST redis
CMD ["java", "-server", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-XX:InitialRAMFraction=2", "-XX:MinRAMFraction=2", "-XX:MaxRAMFraction=2", "-XX:+UseG1GC", "-XX:MaxGCPauseMillis=100", "-XX:+UseStringDeduplication", "-jar", "/root/mmo-server.jar"]

FROM gradle:4.9.0-jdk8 AS builder

ADD src ./src
ADD build.gradle ./build.gradle
ADD settings.gradle ./settings.gradle
RUN gradle build
RUN ls -al

FROM java:8
# copy jar from the first stage
COPY --from=builder /home/gradle/build/libs/spring-cloud-kubernetes-sample.jar spring-cloud-kubernetes-sample.jar

ADD entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
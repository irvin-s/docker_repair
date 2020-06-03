FROM anapsix/alpine-java:8
VOLUME /tmp
ADD shardis-admin-2.2.0.jar app.jar
ADD wait-for-service.sh wait-for-service.sh
RUN bash -c 'touch /app.jar'
RUN bash -c 'touch /wait-for-service.sh'
RUN bash -c 'chmod +x /wait-for-service.sh'
RUN apk --no-cache add curl
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

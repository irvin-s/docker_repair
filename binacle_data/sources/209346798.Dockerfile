FROM daocloud.io/library/java:8
MAINTAINER sxt i_sxt@3songhu.com
VOLUME /tmp
ADD settings-ui-1.0.0-SNAPSHOT.jar app.jar
RUN bash -c "touch app.jar"
EXPOSE 9000
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
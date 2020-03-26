FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY thin/repository /m2/repository
ADD thin/*.jar /runner.jar
ADD function.properties /function.properties
ENV JAVA_OPTS=""
ENTRYPOINT [ "java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "runner.jar", "--thin.root=/m2", "--thin.name=function", "--function.name=uppercase", "--spring.main.sources=com.idugalic.SampleApplication"]
EXPOSE 8080
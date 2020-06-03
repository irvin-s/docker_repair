FROM alpine:3.3

ENV JAVA_HOME=/usr/lib/jvm/default-jvm
RUN apk add --no-cache openjdk8 && \
    ln -sf "${JAVA_HOME}/bin/" "/usr/bin/"

# add jhipster-dashboard source
ENV SPRING_PROFILES=prod
ADD pom.xml mvnw /code/
ADD src /code/src
ADD .mvn /code/.mvn
RUN chmod +x /code/mvnw

# package the application and delete all lib
RUN cd /code/ && \
    ./mvnw package && \
    mv /code/target/*.jar /jhipster-dashboard.jar && \
    rm -Rf /root/.m2/wrapper/ && \
    rm -Rf /root/.m2/repository/

RUN sh -c 'touch /jhipster-dashboard.jar'
EXPOSE 8761
VOLUME /tmp

ENV SPRING_PROFILES_ACTIVE=prod
ENV SPRING_CLOUD_CONFIG_URI=http://registry:8761/config
ENV EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=http://registry:8761/eureka

CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/jhipster-dashboard.jar","--spring.profiles.active=${SPRING_PROFILES}"]

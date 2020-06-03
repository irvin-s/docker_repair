FROM alpine:3.3

ENV JAVA_HOME=/usr/lib/jvm/default-jvm
RUN apk add --no-cache openjdk8 && \
    ln -sf "${JAVA_HOME}/bin/" "/usr/bin/"

# add directly the war
ENV SPRING_PROFILES=dev
ADD *.jar /jhipster-dashboard.jar

RUN sh -c 'touch /jhipster-dashboard.jar'
EXPOSE 8762
VOLUME /tmp
CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/jhipster-dashboard.jar"]

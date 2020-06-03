FROM registry.lubanresearch.com:5000/baseservice:0.1
VOLUME /tmp
ENTRYPOINT java ${JAVA_OPTS} -jar /app.jar --spring.profiles.active=prod
COPY ./target/userservice.jar app.jar
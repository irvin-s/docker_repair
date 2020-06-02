FROM registry.lubanresearch.com:5000/baseui:0.1
VOLUME /tmp
ENTRYPOINT java ${JAVA_OPTS} -jar /app.jar --spring.profiles.active=prod
COPY ./target/usercenter.jar app.jar
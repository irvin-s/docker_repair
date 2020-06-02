FROM maven:3.2-jdk-8 as build
WORKDIR /app
COPY . /app
RUN mvn clean package

FROM openjdk:jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar /app

# environment variable
ENV LOG_DIR $WORKDIR/logs
ENV JAVAPROTOTYPE_MYSQL_CONNECTION_STRING $JAVAPROTOTYPE_MYSQL_CONNECTION_STRING
ENV JAVAPROTOTYPE_MYSQL_CONNECTION_USER $JAVAPROTOTYPE_MYSQL_CONNECTION_USER
ENV JAVAPROTOTYPE_MYSQL_CONNECTION_PASS $JAVAPROTOTYPE_MYSQL_CONNECTION_PASS
# app setup
RUN mkdir -p $WORKDIR/conf
# Placeholder for logging and monitoring agent
RUN mkdir -p $WORKDIR/agent
RUN mkdir -p $LOG_DIR

# Docker daemon log rotation
ADD docker/docker-container \
    /etc/logrotate.d/docker-container

EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java ${JAVA_OPTS} -jar *.jar --spring.config.location=${WORKDIR}/conf/"]

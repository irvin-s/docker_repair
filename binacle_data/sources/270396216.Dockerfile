FROM openjdk:8-jre-alpine

ENV JAVA_OPTIONS ""
ENV LOGS_DIR /var/log/app
ENV APP_DIR /usr/share/app

# Create User java for
RUN adduser -D java

# Create directories for logs and for our java binaries
RUN mkdir -p $LOGS_DIR $APP_DIR && \
    chown -R java $LOGS_DIR $APP_DIR

# Specify that Logs directory can be mounted
VOLUME $LOGS_DIR


# Exposed Ports
ENV PORT 8080
ENV SERVER_PORT $PORT
EXPOSE $PORT

# Add an entrypoint
COPY docker-entrypoint.sh /
RUN chmod u+x /docker-entrypoint.sh && \
  chown java /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# All the remaining actions will be performed as user "java"
USER java

# Add generated binaries
ENV JAR_NAME @project.artifactId@-@project.version@
COPY $JAR_NAME.jar $APP_DIR/bin/

# Command to execute
CMD ["java", "${JAVA_OPTIONS}", "-jar", "${APP_DIR}/bin/${JAR_NAME}.jar"]

FROM openjdk:8
MAINTAINER "Sumanth Chinthagunta"

ARG JAR_NAME
ARG JAVA_OPTS
ARG PORT
VOLUME /tmp
WORKDIR /app
ADD $JAR_NAME app.jar
RUN touch app.jar
EXPOSE $PORT
ENV PORT=$PORT
ENV JAVA_OPTS=$JAVA_OPTS
HEALTHCHECK --interval=90s --timeout=10s --retries=3 CMD curl --fail http://localhost:${PORT}/application/health || exit 1
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Dserver.port=$PORT -Djava.security.egd=file:/dev/./urandom -jar app.jar" ]

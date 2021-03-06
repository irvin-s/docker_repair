FROM andreptb/oracle-java:8-alpine 

WORKDIR /data/

ADD build/libs/*.jar app.jar

ARG PROFILES
ARG PORT
ARG SPRING_PROFILES_ACTIVE
ARG JAVA_OPTS
ARG SERVER_PORT
ARG PATH_JAR

ENV SPRING_PROFILES_ACTIVE ${SPRING_PROFILES_ACTIVE:-${PROFILES:-default}}
ENV JAVA_OPTS ${JAVA_OPTS:-'-Xmx2g'}
ENV SERVER_PORT ${SERVER_PORT:-${PORT:-8080}}

EXPOSE ${SERVER_PORT}

CMD java ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom -jar app.jar
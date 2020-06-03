FROM fabric8/java-jboss-openjdk8-jdk:1.2.3

EXPOSE 8080

# Copy dependencies
COPY target/dependency/* /deployments/libs/

ENV JAVA_APP_DIR=/deployments
ENV JAVA_LIB_DIR=/deployments/libs
ENV JAVA_CLASSPATH=${JAVA_APP_DIR}/classes:${JAVA_LIB_DIR}/*
ENV JAVA_OPTIONS="-Dvertx.cacheDirBase=/tmp -Dvertx.disableDnsResolver=true"
ENV JAVA_MAIN_CLASS="io.vertx.core.Launcher run workshop.trains.DelayedTrains"

# Copy classes
COPY target/classes /deployments/classes

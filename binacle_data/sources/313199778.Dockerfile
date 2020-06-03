FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift

EXPOSE 8080

# Copy dependencies
COPY target/dependency/* /deployments/libs/

ENV JAVA_APP_DIR=/deployments
ENV JAVA_LIB_DIR=/deployments/libs
ENV JAVA_CLASSPATH=${JAVA_APP_DIR}/classes:${JAVA_LIB_DIR}/*
ENV JAVA_OPTIONS="-Dvertx.cacheDirBase=/tmp -Dvertx.disableDnsResolver=true"
ENV JAVA_MAIN_CLASS="io.vertx.core.Launcher run me.escoffier.chaos.api.APIVerticle"

# Copy classes
COPY target/classes /deployments/classes

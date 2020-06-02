FROM airhacks/payara
ENV WAR javaee-cdi-concurrency-utils.war
COPY target/${WAR} ${DEPLOYMENT_DIR}
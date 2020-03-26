FROM dockergarten/payara-micro
MAINTAINER Marcus Fihlon, fihlon.ch
RUN mkdir -p /opt/payara/.sportchef
COPY target/sportchef.war ${DEPLOYMENT_DIR}
HEALTHCHECK CMD curl --fail http://localhost:8080/api/ping/echo/+ || exit 1

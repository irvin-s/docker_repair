FROM openjdk:8-jre-alpine
LABEL maintainer="luk.zim91@gmail.com" \
      service="transmart-api-server" \
      version="17.1-HYVE-5.9-RC3" \
      description="This is the Docker image of the tranSMART API server"

# The port is configured in the docker-entrypoint.sh when writing the config.yml
EXPOSE 8081

ENV TRANSMART_VERSION "17.1-HYVE-5.9-RC3"
ENV TRANSMART_USER_NAME transmart
ENV TRANSMART_GROUP_NAME "${TRANSMART_USER_NAME}"
ENV TRANSMART_USER_HOME "/home/${TRANSMART_USER_NAME}"
ENV TRANSMART_API_SERVER_WAR_URL  "https://repo.thehyve.nl/service/local/repositories/releases/content/org/transmartproject/transmart-api-server/${TRANSMART_VERSION}/transmart-api-server-${TRANSMART_VERSION}.war"
ENV TRANSMART_SERVICE_WAR_FILE "/transmart-api-server.war"

# Root does the following things in this order:
# 1. Copies the entrypoint
# 2. Adds transmart user and group
# 3. Downloads TranSMART API Server war file
# 4. Sets permissions
# 5. Cleanup
USER root
COPY docker-entrypoint.sh /opt/docker-entrypoint.sh
COPY logback.groovy /logback.groovy
RUN  addgroup -S "${TRANSMART_GROUP_NAME}" && \
     adduser -h "${TRANSMART_USER_HOME}" \
             -G "${TRANSMART_GROUP_NAME}" \
             -S \
             -D \
             "${TRANSMART_USER_NAME}" && \
     wget "${TRANSMART_API_SERVER_WAR_URL}" -O "${TRANSMART_SERVICE_WAR_FILE}" && \
     chown    "${TRANSMART_USER_NAME}:${TRANSMART_GROUP_NAME}" /opt/docker-entrypoint.sh && \
     chmod u+x /opt/docker-entrypoint.sh && \
     rm -rf /tmp/* /var/tmp/* && sync

# Set environment for runtime
USER "${TRANSMART_USER_NAME}"
WORKDIR "${TRANSMART_USER_HOME}"
ENTRYPOINT ["/opt/docker-entrypoint.sh"]

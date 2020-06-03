FROM jetty:9.4.2-jre8-alpine

ENV JETTY_WEBAPPS /var/lib/jetty/webapps
ENV BLAZEGRAPH_NAME blazegraph
ENV BLAZEGRAPH_VERSION 2_1_4
ENV BLAZEGRAPH_VERSION_URL https://github.com/blazegraph/database/releases/download/BLAZEGRAPH_RELEASE_${BLAZEGRAPH_VERSION}/blazegraph.war

# Allows you to define the seed data in the docker-compose.data.yml file
ARG SEED

RUN apk --no-cache add openssl curl
RUN mkdir -p ${JETTY_WEBAPPS}/${BLAZEGRAPH_NAME}/ && wget -O ${JETTY_WEBAPPS}/${BLAZEGRAPH_NAME}.war $BLAZEGRAPH_VERSION_URL

RUN unzip ${JETTY_WEBAPPS}/${BLAZEGRAPH_NAME}.war -d ${JETTY_WEBAPPS}/${BLAZEGRAPH_NAME}/ && rm ${JETTY_WEBAPPS}/${BLAZEGRAPH_NAME}.war

COPY jetty-webapp.xml /var/lib/jetty/etc/

RUN chgrp -R 0 /var/lib/jetty && \
    chmod -R g=u /var/lib/jetty

COPY store.properties /tmp/import/store.properties
COPY store_users.properties /tmp/import/store_users.properties
COPY store_sandbox.properties /tmp/import/store_sandbox.properties
COPY create_namespaces.sh /tmp/import/create_namespaces.sh

USER jetty


# Copies Blazegraph Seed ZIP
COPY $SEED /var/lib/jetty/blazegraph_data.zip

# Run remaining commands in this directory
WORKDIR /var/lib/jetty

# Unzip and then delete the zip file containing Blazegraph seed data
# The zip file should contain a file named blazegraph.jnl
RUN unzip blazegraph_data.zip && rm blazegraph_data.zip

CMD cd /var/lib/jetty && java -jar /usr/local/jetty/start.jar

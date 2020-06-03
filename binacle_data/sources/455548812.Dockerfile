FROM spire-base

RUN apt-get install -y --no-install-recommends default-jre

# Install JBOSS
ARG JBOSS_URL="https://storage.googleapis.com/spiffe-example/java-spiffe-federation-demo/wildfly-14.0.1.Final.tar.gz"
ARG JBOSS_DIR=/opt/jboss
RUN curl --silent --location ${JBOSS_URL} | tar -xzf -
RUN mv wildfly-14.0.1.Final ${JBOSS_DIR}

ARG SIMPLE_APP_URL="https://storage.googleapis.com/spiffe-example/java-spiffe-federation-demo/tasks-app-2.0.war"
RUN curl --silent ${SIMPLE_APP_URL} -o tasks-app.war
# Deploy WAR to JBOSS
RUN mv tasks-app.war /opt/jboss/standalone/deployments/ROOT.war

# Download spiffe-provider (java-spiffe library)
ARG JAVA_SPIFFE_URL="https://storage.googleapis.com/spiffe-example/java-spiffe-federation-demo/spiffe-provider-0.3.0.jar"
RUN curl --silent ${JAVA_SPIFFE_URL} -o spiffe-provider.jar

# Configure JBOSS
COPY standalone.xml /opt/jboss/standalone/configuration/
RUN mkdir -p /opt/jboss/modules/system/layers/base/spiffe/main
# JBOSS needs the provider to be installed as a modules so it can find the SocketFactory class
COPY module-spiffe.xml /opt/jboss/modules/system/layers/base/spiffe/main/module.xml
RUN cp spiffe-provider.jar /opt/jboss/modules/system/layers/base/spiffe/main

# Download postgres JDBC driver
ARG POSTGRES_DRIVER_URL="https://storage.googleapis.com/spiffe-example/java-spiffe-federation-demo/postgresql-42.2.5.jar"
RUN curl --silent ${POSTGRES_DRIVER_URL} -o postgresql-42.2.5.jar
RUN mkdir -p /opt/jboss/modules/system/layers/base/org/postgresql/main
# JBOSS needs the provider to be installed as a modules so it can find the SocketFactory class
COPY module-postgres.xml /opt/jboss/modules/system/layers/base/org/postgresql/main/module.xml
RUN mv postgresql-42.2.5.jar /opt/jboss/modules/system/layers/base/org/postgresql/main

# Configure Spire Agent
COPY agent.conf /opt/spire/conf/agent/agent.conf

# Properties for the webapp and JBOSS
RUN mkdir /opt/front-end
COPY database.properties /opt/front-end
COPY start-jboss.sh /opt/front-end
COPY frontend.security /opt/front-end

#Create user for frontend workload
RUN useradd frontend -u 1000


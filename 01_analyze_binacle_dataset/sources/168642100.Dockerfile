# Dockerizing Mule MMC
# Version:  0.1
# Based on:  dockerfile/java (Trusted Java from http://java.com)

FROM                    dockerfile/java:latest
MAINTAINER              Conrad Pöpke <conrad@poepke.info>

# Mule MMC installation:

# This line can reference either a web url (ADD), network share or local file (COPY)
COPY                    ./mmc-distribution-mule-console-bundle-3.5.1.tar.gz /opt/

WORKDIR                 /opt
RUN                     echo "1acdd312c460c9561690179e76561c86 mmc-distribution-mule-console-bundle-3.5.1.tar.gz" | md5sum -c
RUN                     tar -xzvf /opt/mmc-distribution-mule-console-bundle-3.5.1.tar.gz
RUN                     ln -s mmc-distribution-mule-console-bundle-3.5.1/mmc-3.5.1/apache-tomcat-7.0.52 mmc
RUN                     rm -f  mmc-distribution-mule-console-bundle-3.5.1.tar.gz

# Remove things that we don't need in production:
RUN                     rm -Rf mmc-distribution-mule-console-bundle-3.5.1/mule-enterprise-3.5.1
RUN                     rm -f mmc-distribution-mule-console-bundle-3.5.1/startup*
RUN                     rm -f mmc-distribution-mule-console-bundle-3.5.1/shutdown*
RUN                     rm -f mmc-distribution-mule-console-bundle-3.5.1/status*
RUN                     rm -Rf mmc-distribution-mule-console-bundle-3.5.1/mmc-3.5.1/apache-tomcat-7.0.52/webapps/examples
RUN                     rm -Rf mmc-distribution-mule-console-bundle-3.5.1/mmc-3.5.1/apache-tomcat-7.0.52/webapps/host-manager
RUN                     rm -Rf mmc-distribution-mule-console-bundle-3.5.1/mmc-3.5.1/apache-tomcat-7.0.52/webapps/docs
RUN                     rm -Rf mmc-distribution-mule-console-bundle-3.5.1/mmc-3.5.1/apache-tomcat-7.0.52/webapps/manager
RUN                     rm -Rf mmc-distribution-mule-console-bundle-3.5.1/mmc-3.5.1/apache-tomcat-7.0.52/webapps/ROOT/*

# Configure external access:

# Mule remote debugger
EXPOSE  5000

# Mule JMX port (must match Mule config file)
EXPOSE  1098

# Mule MMC port
EXPOSE  8585

# Environment and execution:

CMD             /opt/mmc/bin/startup.sh && tail -f /opt/mmc/logs/catalina.out
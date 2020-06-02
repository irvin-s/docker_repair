# Dockerizing Mule EE
# Version:  0.1
# Based on:  dockerfile/java (Trusted Java from http://java.com)

FROM                    dockerfile/java:latest
MAINTAINER              Conrad Pöpke <conrad@poepke.info>

# MuleEE installation:

# This line can reference either a web url (ADD), network share or local file (COPY)
COPY                    ./mmc-distribution-mule-console-bundle-3.5.1.tar.gz /opt/

WORKDIR                 /opt
RUN                     echo "1acdd312c460c9561690179e76561c86 mmc-distribution-mule-console-bundle-3.5.1.tar.gz" | md5sum -c
RUN                     tar -xzvf /opt/mmc-distribution-mule-console-bundle-3.5.1.tar.gz
RUN                     ln -s mmc-distribution-mule-console-bundle-3.5.1/mule-enterprise-3.5.1 mule
RUN                     rm -f  mmc-distribution-mule-console-bundle-3.5.1.tar.gz

# Copy the license key, keep the license conditions in mind!
WORKDIR                 /opt/mmc-distribution-mule-console-bundle-3.5.1/mule-enterprise-3.5.1
RUN                     rm -Rf .mule
ADD                     ./mule-ee-license.lic /opt/mmc-distribution-mule-console-bundle-3.5.1/mule-enterprise-3.5.1/conf/
RUN                     bin/mule -installLicense conf/mule-ee-license.lic
RUN                     rm -f conf/mule-ee-license.lic
RUN                     rm -Rf apps/default*
RUN                     rm -Rf examples

# Remove things that we don't need in production:
WORKDIR                 /opt/
RUN                     rm -f  mmc-distribution-mule-console-bundle-3.5.1.tar.gz
RUN                     rm -Rf mmc-distribution-mule-console-bundle-3.5.1/mmc-3.5.1
RUN                     rm -f mmc-distribution-mule-console-bundle-3.5.1/startup*
RUN                     rm -f mmc-distribution-mule-console-bundle-3.5.1/shutdown*
RUN                     rm -f mmc-distribution-mule-console-bundle-3.5.1/status*

# Configure external access:

# Mule remote debugger
EXPOSE  5000

# Mule JMX port (must match Mule config file)
EXPOSE  1098

# Mule MMC agent port
EXPOSE  7777

# Environment and execution:

ENV             MULE_BASE /opt/mule
WORKDIR         /opt/mule-enterprise-3.5.1

CMD             /opt/mule/bin/mule
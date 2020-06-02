FROM ubuntu:16.04

# Install the agent, the mongod dependencies, plus: curl, numactl & psmisc
# For mongod dependencies see: https://docs.mongodb.com/manual/tutorial/install-mongodb-enterprise-on-linux/
RUN set -x \
    && apt-get update -y \
    && apt-get install -y \
        curl \
        libcurl3 \
        libgssapi-krb5-2 \
        libkrb5-dbg \
        libldap-2.4-2 \
        libpcap0.8 \
        libpci3 \
        libsasl2-2 \
        libsensors4 \
        libsnmp30 \
        libssl1.0.0 \
        libwrap0 \
        numactl \
        psmisc \
    && curl -OL https://cloud.mongodb.com/download/agent/automation/mongodb-mms-automation-agent-manager_latest_amd64.ubuntu1604.deb \
    && dpkg -i mongodb-mms-automation-agent-manager_latest_amd64.ubuntu1604.deb \
    && rm -rf mongodb-mms-automation-agent-manager_latest_amd64.ubuntu1604.deb \
    && apt-get autoremove \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Two main volumes to be mounted to external volumes: 
#  1) Place for all mongodb cluster configuration & data files
#  2) Place for agent & db binary downloads, for quicker mongod re-start whenever containers are recycled
VOLUME /data /var/lib/mongodb-mms-automation
RUN chown mongodb:mongodb /data /var/lib/mongodb-mms-automation

# Range of potential ports for Cloud Manager configured mongod's to listen on
EXPOSE 27000-28000

# Wrapper script to start the main command (CMD) in the background and register a SIGTERM handler
COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh
ENTRYPOINT ["start.sh"]

# Default to just showing agent help output (see below for proper container start-up command example)
CMD ["/opt/mongodb-mms-automation/bin/mongodb-mms-automation-agent", "-h"]


###############
# HELP / TIPS #
###############

# To build (replace XXXX with your dockerhub username or some other unique identifier):
# $ docker build -t XXXX/automation-agent .

# To run (replace XXXX, YYYY & ZZZZ with your docker hub tag prefix from above, your cloud manager group id and your cloud manager api key, respectively):
# $ docker run -d --name automation-agent-container -t XXXX/automation-agent /opt/mongodb-mms-automation/bin/mongodb-mms-automation-agent --mmsGroupId=YYYY --mmsApiKey=ZZZZ --mmsBaseUrl=https://cloud.mongodb.com -logLevel=INFO


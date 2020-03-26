FROM spire-base

ARG CONFIG_FILE
# Configure Spire Server
COPY $CONFIG_FILE /opt/spire/conf/server/server.conf

WORKDIR /opt/spire

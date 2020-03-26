FROM debian:stable-slim as build

# Configure base image
RUN apt-get update && apt-get install -y \
  wget \
  xz-utils \
  && rm -rf /var/lib/apt/lists/*

# Install Salesforce CLI binary
WORKDIR /
RUN mkdir /sfdx \
    && wget -qO- https://developer.salesforce.com/media/salesforce-cli/sfdx-linux-amd64.tar.xz | tar xJ -C sfdx --strip-components 1 \
    && /sfdx/install \
    && rm -rf /sfdx

### LAST STAGE
FROM debian:stable-slim as run
###

# Setup CLI exports
ENV SFDX_AUTOUPDATE_DISABLE=false \
  # export SFDX_USE_GENERIC_UNIX_KEYCHAIN=true \
  SFDX_DOMAIN_RETRY=300 \
  SFDX_DISABLE_APP_HUB=true \
  SFDX_LOG_LEVEL=DEBUG \
  TERM=xterm-256color

COPY --from=build /usr/local/lib/sfdx /usr/local/lib/sfdx
RUN ln -sf /usr/local/lib/sfdx/bin/sfdx /usr/local/bin/sfdx
RUN sfdx update

# Check version of Salesforce CLI
# RUN sfdx --version && sfdx plugins --core

# copy in entrypoint
COPY docker-entrypoint.sh .

# Make the scripts executeable
RUN chmod +x docker-entrypoint.sh

# Run the entrypoint script on startup
ENTRYPOINT ["/docker-entrypoint.sh"]

# default CMD, should be run in shell so we'll skip the JSON syntax
CMD sfdx help

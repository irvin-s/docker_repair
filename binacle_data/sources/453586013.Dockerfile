#
# Dockerfile.user
#
# This dockerfile is used by Provision on `provision verify` to create containers
# with UIDs that match the host user. This is so the files in volume mounts are
# owned by the same user inside and outside of the container.
#

#
# CUSTOM PROVISION DOCKERFILE SETUP
#
# Custom Dockerfiles for services that need the source code mapped as a volume
# must include the following code to get properly permissioned container.
#
# The build arguments PROVISION_USER_UID and PROVISION_WEB_UID are determined
# automatically by the Provision CLI, and are injected in the main
# docker-compose.yml template.
#
ARG IMAGE_NAME=http
ARG IMAGE_TAG=php7
FROM provision4/$IMAGE_NAME:$IMAGE_TAG
USER root

RUN echo "$RUN_PREFIX Creating set-user-ids script..."
COPY set-user-ids.sh /usr/local/bin/set-user-ids
RUN chmod +x /usr/local/bin/set-user-ids

ARG PROVISION_USER_UID=1000
ENV PROVISION_USER_UID ${PROVISION_USER_UID:-1001}
ARG PROVISION_WEB_UID=1001
ENV PROVISION_WEB_UID ${PROVISION_WEB_UID:-1001}
ENV PROVISION_USER_NAME provision
RUN echo "𝙋𝙍𝙊𝙑𝙄𝙎𝙄𝙊𝙉 Dockerfile.user ║ Running /usr/local/bin/set-user-ids $PROVISION_USER_NAME $PROVISION_USER_UID $PROVISION_WEB_UID"
RUN /usr/local/bin/set-user-ids $PROVISION_USER_NAME $PROVISION_USER_UID $PROVISION_WEB_UID
USER $PROVISION_USER_NAME
#
# END CUSTOM PROVISION DOCKERFILE SETUP
#

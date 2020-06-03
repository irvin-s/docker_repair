#
# Builder
#

ARG BUILDER_IMAGE
FROM ${BUILDER_IMAGE} AS builder
ARG APP_VERSION
RUN directus fetch app ${APP_VERSION}

#
# Project
#

FROM nginx:stable-alpine

# Default variables
ENV ALLOW_OTHER_API "false"
ENV ROUTER_MODE "hash"
ENV ROUTER_BASE_URL "/"

# Copy dist contents to the root folder
COPY --from=builder /directus/tmp/app/ /usr/share/nginx/html/
COPY default.conf /etc/nginx/conf.d/default.conf

# Move the example configuration file into a backup folder
RUN mkdir /directus && \
    mv /usr/share/nginx/html/config_example.js /directus/config.js

# Copy entrypoint
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]

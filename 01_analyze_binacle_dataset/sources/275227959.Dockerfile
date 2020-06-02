# Original source from https://hub.docker.com/_/node/
FROM keymetrics/pm2:latest-alpine
LABEL maintainer="Martin DSouza <martin@talkapex.com>"


# WATCH: If true, will watch for changes in settings.json and restart the node.js app
ENV WATCH="false"

WORKDIR /app
USER root
RUN apk add \
  git && \
  chmod 777 /app

USER node

# For development
# ENV TZ="GMT" \
# RUN cd suez && \
# VOLUME ["/app/suez"]

# RUN TODO RESTORE git clone https://github.com/fuzziebrain/suez.git && \
RUN git clone https://github.com/martindsouza/suez.git && \
  cd suez && \
  rm -rf config && \
  npm install
  
# Volumes:
VOLUME ["/app/suez/config"]

# Ports
EXPOSE 3000

# Enable this if you want the container to permanently run
CMD ["/app/suez/docker-scripts/launch-suez.sh"]

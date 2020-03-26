# Start with Ubuntu 14.04 (LTS), and build a Minion install up from there
FROM ubuntu:14.04
MAINTAINER April King <april@mozilla.com>
ENV MINION_BACKEND /opt/minion/minion-backend
ENV MINION_DOCKERIZED true
EXPOSE 8383

# Move files into place
COPY scan.json /tmp/scan.json

COPY backend.sh /tmp/backend.sh
COPY common.sh /tmp/common.sh

RUN chmod 755 /tmp/backend.sh /tmp/common.sh

# Install common software, setup virtualenv
RUN /bin/bash -c /tmp/common.sh

# Install minion-backend
RUN git clone https://github.com/mozilla/minion-backend.git ${MINION_BACKEND}

# Setup the backend environment
RUN /bin/bash -c /tmp/backend.sh

# Start up Minion backend
CMD service mongodb start && service rabbitmq-server start && service minion start && tail -F /var/log/minion/*

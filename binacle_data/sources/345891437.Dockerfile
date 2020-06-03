# Start with Ubuntu 14.04 (LTS), and build a Minion install up from there
FROM ubuntu:14.04
MAINTAINER April King <april@mozilla.com>
ENV MINION_DOCKERIZED true
ENV MINION_FRONTEND /opt/minion/minion-frontend
EXPOSE 8080

# Move files into place
COPY frontend.json /tmp/frontend.json

COPY frontend.sh /tmp/frontend.sh
COPY common.sh /tmp/common.sh

RUN chmod 755 /tmp/frontend.sh /tmp/common.sh

# Install common software, setup virtualenv
RUN /bin/bash -c /tmp/common.sh

# Install minion-frontend
RUN git clone https://github.com/mozilla/minion-frontend.git ${MINION_FRONTEND}

# Setup the frontend environment
RUN /bin/bash -c /tmp/frontend.sh

# Start up the Minion frontend
CMD service minion start && tail -F /var/log/minion/*
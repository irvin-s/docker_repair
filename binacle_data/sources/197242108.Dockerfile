# Docker file for ALICE OVERWATCH Dev
ARG PYTHON_VERSION=2.7.15
FROM overwatch:latest-py${PYTHON_VERSION}
LABEL maintainer="Raymond Ehlers <raymond.ehlers@cern.ch>, Yale University"

# Vim
RUN apt-get update && apt-get install -y \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Update Overwatch to the most recent version
# NOTE: Updating here will cause a problem if we make changes to the receiver, but such changes
#       are infrequent, so it should be fine
RUN git fetch && echo "" && git checkout master && git pull

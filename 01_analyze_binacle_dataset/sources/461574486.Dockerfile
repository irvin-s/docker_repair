FROM python:3.6-slim
MAINTAINER Product Delivery irc://irc.mozilla.org/#storage-team

ENV PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app/

# add a non-privileged user for installing and running the application
# don't use --create-home option to prevent populating with skeleton files
RUN mkdir /app && \
    chown 10001:10001 /app && \
    groupadd --gid 10001 app && \
    useradd --no-create-home --uid 10001 --gid 10001 --home-dir /app app

# install a few essentials and clean apt caches afterwards
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https build-essential curl git zip netcat

# Clean up apt
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . /app

# Install Python dependencies
RUN pip install -e app/jobs/
COPY jobs/requirements /tmp/requirements
# Switch to /tmp to install dependencies outside home dir
WORKDIR /tmp
RUN ls /tmp
RUN pip install --no-cache-dir \
  -r requirements/default.txt \
  -r requirements/dev.txt \
  -c requirements/constraints.txt

COPY . /app

# Switch back to home directory
WORKDIR /app


RUN chown -R 10001:10001 /app

USER 10001


# Using /bin/bash as the entrypoint works around some volume mount issues on Windows
# where volume-mounted files do not have execute bits set.
# https://github.com/docker/compose/issues/2301#issuecomment-154450785 has additional background.
ENTRYPOINT ["/bin/bash", "/app/bin/run.sh"]

CMD ["help"]

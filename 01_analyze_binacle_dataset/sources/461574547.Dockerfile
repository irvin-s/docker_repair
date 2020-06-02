FROM python:3.6-slim
MAINTAINER Product Delivery irc://irc.mozilla.org/#storage-team

ENV PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app/ \
    PORT=9999

EXPOSE $PORT

# install a few essentials and clean apt caches afterwards
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https build-essential curl

# Clean up apt
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY testkinto/requirements.txt /tmp/
WORKDIR /tmp
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app

# Switch back to home directory
WORKDIR /app


# Using /bin/bash as the entrypoint works around some volume mount issues on Windows
# where volume-mounted files do not have execute bits set.
# https://github.com/docker/compose/issues/2301#issuecomment-154450785 has additional background.
ENTRYPOINT ["/bin/bash", "/app/testkinto/run.sh"]

CMD ["start"]

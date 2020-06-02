## Pull base image
FROM runbook/runbook:{{ git_branch }}

MAINTAINER Benjamin Cane <ben@bencane.com>

# Install required packages
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y stunnel supervisor git
RUN rm -rf /var/lib/apt/lists/*

RUN useradd -g users runapp

# Create working directories
RUN mkdir -p /code /config /data

# Copy Configurations
ADD config/bridge.yml /config/bridge.yml
ADD config/stunnel-client.conf /config/stunnel-client.conf
ADD config/supervisord.conf /config/supervisord.conf
ADD config/ssl/key.pem /config/key.pem
ADD config/ssl/cert.pem /config/cert.pem
ADD config/mgmtrun.sh /code/mgmtrun.sh

# Reset Perms
RUN chown -R runapp:users /config /code /src

# Command to run
CMD /usr/bin/supervisord -c /config/supervisord.conf

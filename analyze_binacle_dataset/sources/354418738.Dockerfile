################################################################################
# Base image
################################################################################

FROM percona:5.6

################################################################################
# Build instructions
################################################################################

USER root

# Copy mysql config to container.
COPY config/mysql.cnf /etc/mysql/conf.d/

# Ensure that mysql is run as root.
RUN sed -i "s/user\s*=\s*mysql/user = root/" /etc/mysql/my.cnf

# Install Supervisor and copy config.
RUN apt-get update && apt-get install -y supervisor
COPY config/supervisor.conf /etc/supervisor/conf.d/

################################################################################
# Volumes
################################################################################

# Expose logging volumes.
VOLUME "/var/log/mysql/"

################################################################################
# Entrypoint
################################################################################

ENTRYPOINT ["/usr/bin/supervisord"]

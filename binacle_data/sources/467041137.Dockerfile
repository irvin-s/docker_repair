# dev image dockerfile

FROM flaskbp-base

# Install Postgres 10 and git
RUN set -x && \
    echo 'deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main' > /etc/apt/sources.list.d/pgdg.list && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get -q update --fix-missing && \
    apt-get -q install -y --no-install-recommends postgresql-10 postgresql-contrib-10 postgresql-server-dev-10 \
                                                  postgresql-common git nodejs npm rsync wget unzip \
                                                  build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Symlink workspace assets
RUN set -x && \
    mkdir -p /opt/flaskbp && \
    ln -s /workspace/etc /opt/flaskbp/etc && \
    ln -s /workspace/etc/config.yml /home/flaskbp/config.yml

# Install opensource dependencies
COPY requirements.txt /home/flaskbp
RUN set -x && \
    pip3 install -r /home/flaskbp/requirements.txt && \
    chown -R flaskbp.flaskbp /home/flaskbp/*

# Expose port 5000 for dev API server
EXPOSE 5000

# Mark volumes
VOLUME ["/workspace"]

# Copy entrypoint script
COPY docker/dev/entrypoint.sh /entrypoint.sh

# Make sure permissions are set properly on entrypoint
RUN set -x && chmod a+x /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["gosu", "flaskbp", "/entrypoint.sh"]

# Set default command - interpreted by entrypoint
CMD ["shell"]
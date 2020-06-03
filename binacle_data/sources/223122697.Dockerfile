FROM {{ image_spec("base-tools") }}
MAINTAINER {{ maintainer }}

# Install Snap
ADD install.sh /tmp/
RUN mkdir -p /etc/snap/auto \
    && bash /tmp/install.sh /etc/snap/auto \
    && rm /tmp/install.sh \
    && useradd --user-group snap \
    && usermod -a -G microservices snap \
    && chown -R snap: /etc/snap \
    && apt-get purge -y --auto-remove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER snap

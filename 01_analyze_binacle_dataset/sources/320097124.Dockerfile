FROM dockette/debian:sid

MAINTAINER Milan Sulc <sulcmil@gmail.com>

RUN apt-get update && \
    apt-get install -y varnish && \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

# Varnish variables
ENV VARNISH_SECRET /etc/varnish/secret
ENV VARNISH_CONFIG /etc/varnish/default.vcl
ENV VARNISH_CACHE 256m
ENV VARNISH_PORT 80

# Varnish configuration
ADD ./varnish/default.vcl $VARNISH_CONFIG

# Entrypoint
ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]

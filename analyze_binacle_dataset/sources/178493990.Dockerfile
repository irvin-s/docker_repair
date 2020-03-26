FROM htmlgraphic/base
MAINTAINER Jason Gegere <jason@htmlgraphic.com>

# Install packages then remove cache package list information
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
 supervisor \
 rsyslog \
 postfix && apt-get clean && rm -rf /var/lib/apt/lists/*


# Copy files / scripts to build application
RUN mkdir -p /opt
COPY ./app /opt/app
COPY ./tests /opt/tests

# Unit tests run via build_tests.sh
RUN tar xf /opt/tests/2.1.6.tar.gz -C /opt/tests/

RUN debconf-set-selections /opt/app/preseed.txt

# SUPERVISOR
RUN chmod -R 755 /opt/* && \
		mkdir -p /var/log/supervisor && \
		cp /opt/app/supervisord.conf /etc/supervisor/conf.d/

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Postix Docker" \
      org.label-schema.description="Docker container running Posfix running on Ubuntu, TDD via Shippable & CircleCI" \
      org.label-schema.url="https://htmlgraphic.com" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/htmlgraphic/Apache" \
      org.label-schema.vendor="HTMLgraphic, LLC" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

# Note that EXPOSE only works for inter-container links. It doesn't make ports accessible from the host. To expose port(s) to the host, at runtime, use the -p flag.
EXPOSE 25

CMD ["/opt/app/run.sh"]

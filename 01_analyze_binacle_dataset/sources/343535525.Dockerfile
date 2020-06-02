# Autopilot pattern Couchbase
FROM couchbase/server:enterprise-4.0.0

# install jq
RUN apt-get update && \
    apt-get install -y \
    jq \
    && rm -rf /var/lib/apt/lists/*

# get ContainerPilot release
ENV CONTAINERPILOT_VERSION 2.0.0
ENV CONTAINERPILOT file:///etc/containerpilot.json

RUN export CP_SHA1=a82b1257328551eb93fc9a8cc1dd3f3e64664dd5 \
    && curl -Lso /tmp/containerpilot.tar.gz \
         "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VERSION}/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" \
    && echo "${CP_SHA1}  /tmp/containerpilot.tar.gz" | sha1sum -c \
    && tar zxf /tmp/containerpilot.tar.gz -C /bin \
    && rm /tmp/containerpilot.tar.gz

# Add ContainerPilot configuration files and handlers
COPY etc/containerpilot.json etc/containerpilot.json
COPY bin/* /usr/local/bin/

# Metadata
EXPOSE 8091 8092 11207 11210 11211 18091 18092
VOLUME /opt/couchbase/var

CMD ["/bin/containerpilot", \
     "/usr/sbin/runsvdir-start", \
     "couchbase-server", \
     "--", \
     "-noinput"] # so we don't get dropped into the erlang shell

FROM alpine:3.9
MAINTAINER Chris Marchesi <chrism@vancluevertech.com> (@vancluever)

# This is the release of Nomad to pull in.
ARG NOMAD_VERSION
ENV NOMAD_VERSION=${NOMAD_VERSION}

# Create a nomad user and group first so the IDs get set the same way, even as
# the rest of this may change over time.
RUN addgroup nomad && \
    adduser -S -G nomad nomad

# Set up certificates and our base tools
RUN apk add --no-cache ca-certificates curl dumb-init libcap su-exec

# We use a pre-staged static Nomad binary as upstream binaries are linked
# against only LXC or glibc. The Dockerfile expects this at pkg/nomad.
COPY pkg/nomad /bin/nomad

# The /nomad/data dir is used by Nomad to store state. The agent will be started
# with /nomad/config as the configuration directory so you can add additional
# config files in that location.
RUN mkdir -p /nomad/data && \
    mkdir -p /nomad/config && \
    chown -R nomad:nomad /nomad

# Server RPC is used for internal RPC communication between agents and servers,
# and for inter-server traffic for the consensus algorithm (raft).
EXPOSE 4647

# Serf is used as the gossip protocol for cluster membership. Both TCP and UDP
# should be routable between the server nodes on this port.
EXPOSE 4648 4648/udp

# HTTP is the primary interface that applications use to interact with Nomad.
EXPOSE 4646

# Nomad doesn't need root privileges so we run it as the nomad user from the
# entry point script. The entry point script also uses dumb-init as the top-level
# process to reap any zombie processes created by Nomad sub-processes.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# By default you'll get an insecure single-node development server that stores
# everything in RAM, exposes HTTP endpoints, and bootstraps itself.  Don't use
# this configuration for production.
CMD ["agent", "-dev"]

#
# This builds an image that should be usable as a starting point for
# most or all of LeastAuthority's Docker images.  The anticipated name
# for the image is <leastauthority/base>.
#

#
# Attempts are made to follow the guidelines at
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/
#

# Ubuntu 14.04 is the known-working baseline OS.  Others probably work
# but this is a reasonable starting place.  14.04.5 already has many
# updates applied so it makes more sense as a starting place than the
# original 14.04.
FROM library/ubuntu:14.04.5

# If there are security updates for any of the packages we install,
# bump the date in this environment variable to invalidate the Docker
# build cache and force installation of the new packages.  Otherwise,
# Docker's image/layer cache may prevent the security update from
# being retrieved.
ENV SECURITY_UPDATES="2017-02-17"

# Set a build-only environment variable to suppress warnings from apt
# and other package management tools caused by the lack of a tty.
# This can be overridden by --build-arg but that's not the point.
# See https://github.com/docker/docker/issues/4032
ARG DEBIAN_FRONTEND=noninteractive

# We'll do an upgrade because the base Ubuntu image isn't guaranteed
# to include the latest security updates.  This is counter to best
# practice recommendations but security updates are important.
RUN apt-get --quiet update && \
    apt-get --quiet install -y unattended-upgrades && \
    unattended-upgrade --minimal_upgrade_steps && \
rm -rf /var/lib/apt/lists/*

# Now install some dependencies.
#
# The first group of non-Python dependencies required to build the
# Python dependencies.
#
# The second group supports the deployment of the infrastructure
# server.
RUN apt-get --quiet update && apt-get --quiet install -y \
    python-dev \
    git-core \
    libffi-dev \
    openssl \
    libssl-dev \
    \
    python-virtualenv \
&& rm -rf /var/lib/apt/lists/*

# Create a virtualenv into which to install the infrastructure server
# software.
RUN virtualenv /app/env

# Get the latest version of setuptools.  Some packages are not installable
# with older versions.
RUN /app/env/bin/pip install --upgrade setuptools

# Get a newer version of pip.  The version (1.5.4) in the
# python-virtualenv OS package has a bug that prevents it from
# installing txAWS.
RUN /app/env/bin/pip install --upgrade pip

# Also a TLS/SNI-capable install of urllib3 (which doesn't happen by default
# ...)
RUN /app/env/bin/pip install --upgrade urllib3[secure]

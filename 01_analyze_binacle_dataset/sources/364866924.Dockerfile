FROM debian:latest
MAINTAINER Martin Lucina <martin@lucina.net>

# Install build prerequisites.
# ca-certificates is required for git clone https:// to work
# sudo is required for step-up to root
# xorriso, grub-pc-bin and genisoimage are useful for downstream use (rumprun iso)
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
        --no-install-recommends \
        build-essential \
        ca-certificates \
        genisoimage \
        git \
        grub-pc-bin \
        libxen-dev \
        sudo \
        xorriso \
        zlib1g-dev \
    && apt-get clean

# Add a non-root user to run the build under, giving them sudo permissions
# to install the built toolchain.
RUN useradd -r -g root --uid=999 -m -d /build -s /bin/bash build && \
    echo "build ALL = NOPASSWD: ALL" > /etc/sudoers.d/build

# "Docker run" should land in the "build" user.
USER build

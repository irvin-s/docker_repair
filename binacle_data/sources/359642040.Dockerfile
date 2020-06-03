FROM debian:jessie

# Install packages and download the repo
RUN apt-get update && apt-get install -y -q \
    git \
    fakeroot \
    ca-certificates \
    && rm -rf /var/cache/apt/* /var/lib/apt/lists/* \
    && git clone https://github.com/luxas/kubernetes-on-arm

# Copy the script and the control file
COPY makedeb.sh debian-control-file /

# Always run this script
ENTRYPOINT ["/makedeb.sh"]

# flask-bp base image dockerfile

# use ubuntu 18.04 as base image
FROM ubuntu:18.04

# Set environment (set proper unicode locale, hush debconfig, etc.
# Set PATH so that subsequent pip3 commands install into virtualenv.
# activate command does not work within Docker for some reason
ENV DEBIAN_FRONTEND=noninteractive \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    PATH=/home/flaskbp/flaskbp-venv/bin:$PATH \
    GOSU_VERSION=1.10

#
# - Set default shell to bash,
# - Update package lists
# - Install APT depdendencies
#
RUN set -x && \
    unlink /bin/sh; ln -s bash /bin/sh && \
    apt-get -q update && \
    apt-get -q install -y --no-install-recommends locales apt-utils git libpq-dev python3-pip \
                                                  python3-venv zip unzip wget default-jre-headless build-essential \
                                                  python3-dev vim nano gnupg && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#
# Set default locale
#
RUN update-locale LC_ALL=C.UTF-8 LANG=C.UTF-8

# Install gosu
RUN set -x && \
    wget -q -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true

# create a non-root flask-bp user
RUN set -x && \
    groupadd -g 9001 flaskbp && \
    useradd -m -d /home/flaskbp -s /bin/bash -u 9001 -g 9001 flaskbp

#
# - Create flaskbp virtualenv
# - Upgrade pip and install wheel
# - Fix permissions, as pip3 installs are being done as root here
#
RUN set -x && \
    echo 'test -z "$VIRTUAL_ENV" && source /home/flaskbp/flaskbp-venv/bin/activate' >> /home/flaskbp/.bashrc && \
    pyvenv /home/flaskbp/flaskbp-venv && \
    pip3 install --upgrade pip setuptools && \
    pip3 install wheel && \
    chown -R flaskbp.flaskbp /home/flaskbp/.bashrc /home/flaskbp/flaskbp-venv && \
    echo 'if [ -f /home/flaskbp/.flaskbpenv ]; then source /home/flaskbp/.flaskbpenv; fi' >> /home/flaskbp/flaskbp-venv/bin/activate


# Create log volume dir and make sure it has the correct permissions
RUN set -x && \
    mkdir -p /var/log/flaskbp && \
    chown -R flaskbp.flaskbp /var/log/flaskbp

# Mark log volume
VOLUME ["/var/log/flaskbp"]

# Override in child container
CMD ["gosu", "flaskbp", "/bin/bash"]

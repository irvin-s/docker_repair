FROM debian:9 as builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        libc6-dev

COPY /docker/common/src /src

RUN gcc -Wall -DCOMMAND='"/bootstrap/start-systemd.sh"' -o /systemd-wrapper /src/start-setuid.c

#####

FROM debian:9

ARG SALT_VERSION
ARG SALT_PATH
ARG PYZMQ_VERSION
ARG PYTHON_APT_VERSION
ARG TRACE
ARG OS
ARG OS_TYPE

LABEL maintainer=Hortonworks

ARG SYSTEMCTL=https://raw.githubusercontent.com/hortonworks/docker-systemctl-replacement/3a885817b377f0307bd03d82323fa5749136de8f/files/docker/systemctl.py

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
ENV PS1 "[\u@cloudbreak \W]\$ "

# Set default shell to bash
SHELL ["/bin/bash", "-c"]

# Install packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        cron \
        curl \
        gnupg2 \
        initscripts \
        iproute2 \
        python-minimal \
        ssh \
        sudo \
        systemd && \
    rm -rf /var/lib/apt/lists/*

# Unneeded systemd services
RUN (cd /lib/systemd/system/sysinit.target.wants && \
    ls | grep -v systemd-tmpfiles-setup.service | xargs rm) && \
    rm -f /lib/systemd/system/multi-user.target.wants/* && \
    rm -f /lib/systemd/system/local-fs.target.wants/* && \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
    rm -f /lib/systemd/system/basic.target.wants/* && \
    rm -f /etc/systemd/system/*.wants/*

# Replace systemctl during SaltStack provisioning
RUN dpkg-divert --add --rename /bin/systemctl && \
    curl -s -o /bin/systemctl $SYSTEMCTL && \
    chmod 755 /bin/systemctl

# SaltStack provisioning
COPY /saltstack/ /tmp/saltstack/
COPY /repos/     /tmp/repos/
COPY /scripts/   /tmp/scripts/
COPY /scripts/salt_requirements.txt /tmp/salt_requirements.txt
COPY docker/common/_grains/ /tmp/saltstack/base/salt/_grains/
COPY docker/common/_grains/ /tmp/saltstack/hortonworks/salt/_grains/
RUN printf '\n\nproviders:\n  service: systemd\n' >>/tmp/saltstack/config/minion
RUN /tmp/scripts/salt-install.sh debian
RUN /tmp/scripts/salt-setup.sh hortonworks

# Fix SaltStack init autodiscovery
RUN printf '\n\nproviders:\n  service: systemd\n' >>/etc/salt/minion
COPY docker/common/_grains/ /srv/salt/_grains/

# Fix startup problems for Type=notify systemd services
COPY docker/common/systemd-fix.service /etc/systemd/system/
RUN systemctl enable systemd-fix

# Undo systemctl replacement
RUN rm /bin/systemctl && \
    dpkg-divert --remove --rename /bin/systemctl

# Fix ssh login and salt-api auth problems
RUN rm /lib/systemd/system/rmnologin.service && \
    sed -i 's/#\?DELAYLOGIN=.*/DELAYLOGIN=yes/' /etc/default/rcS

# Ycloud integration
RUN groupmod -g 99 nogroup && \
    usermod -u 99 -g nogroup nobody

# CloudBreak expects /bootstrap/start-systemd as an entrypoint
COPY docker/common/start-systemd.sh /bootstrap/start-systemd.sh
COPY --from=builder /systemd-wrapper /bootstrap/start-systemd
RUN chown root:nogroup /bootstrap/start-systemd && \
    chmod 4750 /bootstrap/start-systemd

RUN systemctl enable ssh cron

EXPOSE 22

CMD ["/bootstrap/start-systemd"]

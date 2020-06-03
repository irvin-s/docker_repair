FROM rallyforge/rally:latest
MAINTAINER Yaroslav Lobankov <ylobankov@mirantis.com>

# We need to switch to 'root' user to avoid permission issues.
USER root

WORKDIR /tmp
RUN git clone https://git.openstack.org/openstack/tempest && \
    pip install -r tempest/requirements.txt -r tempest/test-requirements.txt && \
    mv tempest/ /var/lib/

COPY setup_tempest.sh /usr/bin/setup-tempest
RUN chown rally /usr/bin/setup-tempest

WORKDIR /home/rally

# Switch to 'rally' user back.
USER rally

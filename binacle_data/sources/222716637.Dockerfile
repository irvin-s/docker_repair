FROM {{ image_spec("neutron-base") }}
MAINTAINER {{ maintainer }}

COPY neutron_sudoers /etc/sudoers.d/neutron_sudoers
RUN chmod 750 /etc/sudoers.d \
    && chmod 440 /etc/sudoers.d/neutron_sudoers

USER neutron

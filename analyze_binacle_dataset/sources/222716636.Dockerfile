FROM {{ image_spec("neutron-base") }}
MAINTAINER {{ maintainer }}

RUN apt-get -y install --no-install-recommends \
        keepalived \
    && apt-get clean

FROM {{ image_spec("nova-base") }}
MAINTAINER {{ maintainer }}

RUN apt-get -y install --no-install-recommends \
        genisoimage \
    && apt-get clean

USER nova

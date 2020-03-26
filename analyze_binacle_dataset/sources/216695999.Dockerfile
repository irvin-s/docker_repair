FROM {{ image_spec("nova-base") }}
MAINTAINER {{ maintainer }}

RUN apt-get install -y --no-install-recommends \
        mysql-client \
    && apt-get clean

USER nova

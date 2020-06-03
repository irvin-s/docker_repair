FROM {{ image_spec("nova-base") }}
MAINTAINER {{ maintainer }}

COPY daemon.sh /usr/local/bin/daemon.sh

RUN apt-get install -y --no-install-recommends \
        apache2  \
        libapache2-mod-wsgi \
    && apt-get clean \
    && chmod 755 /usr/local/bin/daemon.sh \
    && usermod -aG www-data nova \
    && echo > /etc/apache2/ports.conf

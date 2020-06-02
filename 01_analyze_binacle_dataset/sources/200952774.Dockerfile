FROM python:3.6.6-jessie
MAINTAINER Hibou Corp. <hello@hibou.io>

# add user with the same user id as in core odoo package
# unfortunately python comes with group 107 already defined so I used www-data as group
RUN useradd -m -d /var/lib/odoo -s /bin/false -u 104 -g 33 odoo

# Generate locale C.UTF-8 for postgres and general locale data - Debian Jessie
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && apt-get install -y locales -qq \
    && echo 'C.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen \
    && dpkg-reconfigure locales && /usr/sbin/update-locale LANG=C.UTF-8
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
        apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
        && curl -o wkhtmltox.deb -SL http://nightly.odoo.com/extra/wkhtmltox-0.12.1.2_linux-jessie-amd64.deb \
        && echo '40e8b906de658a2221b15e4e8cd82565a47d7ee8 wkhtmltox.deb' | sha1sum -c - \
        && dpkg --force-depends -i wkhtmltox.deb \
        && apt-get -y install -f --no-install-recommends \
        && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false npm \
        && rm -rf /var/lib/apt/lists/* wkhtmltox.deb

# support for Postgresql9.6
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main 9.6" > /etc/apt/sources.list.d/postgresql.list \
        && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
        && apt-get update \
        && apt-get upgrade -y postgresql-common \
        && apt-get upgrade -y postgresql-client

# install newer node and lessc (mostly for less compatibility)
RUN set -x; \
        curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs \
        && npm install -g less \
        ;
 
# python python-minimal python2.7 python2.7-minimal
RUN apt-get purge -y python.*

# Install Odoo
ENV ODOO_VERSION 11.0
ENV ODOO_RELEASE 20180122
RUN set -x; \
        apt-get install -y libsasl2-dev libldap2-dev libssl-dev gcc \
        && curl -o odoo.tar.gz -SL https://nightly.odoo.com/${ODOO_VERSION}/nightly/src/odoo_${ODOO_VERSION}.${ODOO_RELEASE}.tar.gz \
        && tar xzf odoo.tar.gz \
        && cd odoo-* \
        && pip install -r ./requirements.txt \
        && pip install . \
        && cd .. && rm -rf ./odoo* \
        && pip install --upgrade \
            cryptography \
            watchdog \
            newrelic \
            xlwt \
            num2words \
            phonenumbers \
            pyOpenSSL \
            markdown \
            # Additional for Order Planner/geolocalization \
            uszipcode \
            # Additional for Connectors (e.g. Walmart and Magento) \
            cachetools \
            magento \
            pycryptodome \
        && apt-get purge -y \
            gcc \
            libsasl2-dev \
            libldap2-dev \
            libssl-dev


# Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
COPY ./odoo.conf /etc/odoo/
RUN chown odoo /etc/odoo/odoo.conf

# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons \
        && chown -R odoo /mnt/extra-addons
VOLUME ["/var/lib/odoo", "/mnt/extra-addons"]

# Expose Odoo services
EXPOSE 8069 8072

# Set the default config file - NOTE this is still used in odoo/tools/config.py in v10
ENV ODOO_RC /etc/odoo/odoo.conf

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]

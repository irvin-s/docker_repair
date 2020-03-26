FROM adhoc/odoo-ubuntu:11.0
MAINTAINER Juan Jose Scarafia <jjs@adhoc.com.ar>

USER root

# Other requirements, useful tools and recommendations to run Odoo (libldap2-dev libsasl2-dev re recommended by odoo here https://www.odoo.com/documentation/11.0/setup/install.html). libcups2-dev is for aeroo. Then install locales and later clean everything
RUN apt-get -qq update && apt-get install -yqq --no-install-recommends \
    git nano htop ssh wget unzip iputils-ping telnet \
    postgresql-client-9.6 \
    python3-dev build-essential \
    libldap2-dev libsasl2-dev \
    libcups2-dev \
    locales \
    && locale-gen en_US.UTF-8 && update-locale \
    && locale-gen es_AR.UTF-8 && update-locale \
    && echo 'LANG="en_US.UTF-8"' > /etc/default/locale \
    && pip3 install --no-cache-dir --upgrade pip setuptools \
    && pip3 install --no-cache-dir  num2words wheel vobject qrcode git+https://github.com/OCA/openupgradelib/@master \
    && apt-get purge -yqq build-essential '*-dev' \
    && apt-get -yqq autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Generate locale (es_AR for right odoo es_AR language config, and C.UTF-8 for postgres and general locale data). TODO better C.UTF-8 or en_US.UTF-8?
ENV LANG es_AR.UTF-8  
ENV LANGUAGE es_AR:es:en_US:en  
ENV LC_ALL es_AR.UTF-8

# Make auto_install = False for various modules
RUN sed  -i  "s/'auto_install': True/'auto_install': False/" /usr/lib/python3/dist-packages/odoo/addons/procurement_jit/__manifest__.py

# create directory for odoo files
ENV ETC_DIR /opt/odoo/etc
ENV DATA_DIR /opt/odoo/data
ENV CUSTOM_ADDONS /opt/odoo/custom-addons
ENV EXTRA_ADDONS /opt/odoo/extra-addons
RUN mkdir -p /opt/odoo \
    && mkdir -p ${ETC_DIR} \
    && mkdir -p ${DATA_DIR} \
    && mkdir -p ${CUSTOM_ADDONS} \
    && mkdir -p ${EXTRA_ADDONS} \
    && chown -R odoo.odoo /opt/odoo

# Mount persistent directories
#VOLUME ["${DATA_DIR}", "${CUSTOM_ADDONS}"]

USER odoo

# rplace  entrypoint script and replace Odoo configuration file (new name)
ENV RESOURCES /opt/odoo/resources/
COPY ./resources/ ${RESOURCES}

# change entrypoint
ENTRYPOINT ["/opt/odoo/resources/entrypoint.sh"]
CMD ["odoo"]

# Variables used by the launch scripts
ENV \
    ODOO_SERVER=odoo.py \
    ODOO_CONF=/opt/odoo/etc/odoo.conf \
    FIXDBS=False \
    WAIT_PG=True \
    PG_MAX_CONNECTIONS=100 \
    # odoo conf variables
    MAX_CRON_THREADS=1 \
    SMTP_SERVER=localhost \
    SMTP_PORT=25 \
    SMTP_SSL=False \
    SMTP_USER=False \
    SMTP_PASSWORD=False \
    UNACCENT=True \
    PGUSER=odoo \
    PGPASSWORD=odoo \
    PGHOST=db \
    WORKERS=6 \
    ADMIN_PASSWORD=admin \
    SERVER_MODE=test \
    DISABLE_SESSION_GC=false \
    PROXY_MODE=True \
    WITHOUT_DEMO=True \
    DBFILTER=.* \
    LIMIT_TIME_CPU=1600 \
    LIMIT_TIME_REAL=3200 \
    LIMIT_MEMORY_HARD=2684354560 \
    LIMIT_MEMORY_SOFT=2147483648 \
    AEROO_DOCS_HOST=aeroo \
    AFIP_HOMO_PKEY_FILE=/opt/odoo/backups/homo.pkey \
    AFIP_HOMO_CERT_FILE=/opt/odoo/backups/homo.cert \
    AFIP_PROD_PKEY_FILE=/opt/odoo/backups/prod.pkey \
    AFIP_PROD_CERT_FILE=/opt/odoo/backups/prod.cert \
    DB_TEMPLATE=template1

# odoo server use this env var as default conf, check if v9 or v10 rename it
ENV ODOO_RC $ODOO_CONF

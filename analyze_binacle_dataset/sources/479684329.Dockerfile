FROM adhoc/odoo-ubuntu:8.0
MAINTAINER Juan Jose Scarafia <jjs@adhoc.com.ar>

USER root

# Generate locale (es_AR for right odoo es_AR language config, and C.UTF-8 for postgres and general locale data)
# TODO better C.UTF-8 or en_US.UTF-8?
RUN locale-gen en_US.UTF-8 && update-locale
RUN locale-gen es_AR.UTF-8 && update-locale
RUN echo 'LANG="en_US.UTF-8"' > /etc/default/locale
ENV LANG es_AR.UTF-8  
ENV LANGUAGE es_AR:es:en_US:en  
ENV LC_ALL es_AR.UTF-8

# Install some deps (if we install with no-recommends later we have some errors with pip)
RUN apt-get update \
        && apt-get install -y \
        python-pip git

# sudo and other useful tools
RUN apt-get install -y sudo nano htop ssh wget unzip

# update pip and install setuptools (required for intalling pip requirements)
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools

# Workers and longpolling dependencies
RUN apt-get install -y python-gevent
RUN pip install psycogreen

## Install pip dependencies for adhoc used odoo repositories
RUN pip install openupgradelib

# used by many pip packages
RUN apt-get install -y python-dev build-essential

# odoo-extra
RUN apt-get install -y python-matplotlib font-manager
RUN pip install simplejson

# odoo argentina (nuevo modulo de FE)
RUN apt-get install -y swig libffi-dev libssl-dev python-m2crypto python-httplib2
# este deberiamos borrarlo porque tarda, es para pyOpenSSL que no deberia ser necesario si usamos pyafipws

# aeroo direct print
RUN apt-get install -y libcups2-dev

# fix for this issue https://github.com/odoo/odoo/issues/9113 (issue raised when installing website_animate)
RUN apt-get install -y npm
RUN npm install -g less less-plugin-clean-css
RUN apt-get install -y nodejs-legacy
RUN rm /usr/bin/lessc; ln -s /usr/local/bin/lessc /usr/bin/lessc
RUN apt-mark hold node-less

## Clean apt-get (copied from odoo)
RUN apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Make auto_install = False for various modules
RUN sed  -i  "s/'auto_install': True/'auto_install': False/" /usr/lib/python2.7/dist-packages/openerp/addons/im_chat/__openerp__.py

RUN sed  -i  "s/'auto_install': True/'auto_install': False/" /usr/lib/python2.7/dist-packages/openerp/addons/im_odoo_support/__openerp__.py

RUN sed  -i  "s/'auto_install': True/'auto_install': False/" /usr/lib/python2.7/dist-packages/openerp/addons/bus/__openerp__.py

RUN sed  -i  "s/'auto_install': True/'auto_install': False/" /usr/lib/python2.7/dist-packages/openerp/addons/base_import/__openerp__.py

RUN sed  -i  "s/'auto_install': True/'auto_install': False/" /usr/lib/python2.7/dist-packages/openerp/addons/portal/__openerp__.py

# create directory for odoo files
RUN mkdir -p /opt/odoo
RUN chown -R odoo /opt/odoo

# changing user is required by odoo which won't start with root
USER odoo
ENV ETC_DIR /opt/odoo/etc
ENV DATA_DIR /opt/odoo/data
ENV CUSTOM_ADDONS /opt/odoo/custom-addons
ENV EXTRA_ADDONS /opt/odoo/extra-addons
RUN mkdir -p ${ETC_DIR}
RUN mkdir -p ${DATA_DIR}
RUN mkdir -p ${CUSTOM_ADDONS}
RUN mkdir -p ${EXTRA_ADDONS}

USER root

# Mount persistent directories
VOLUME ["${DATA_DIR}", "${CUSTOM_ADDONS}"]
# no tendriamos porque montar "/opt/odoo/etc" ya que la idea es que se reconstruya el conf dinamicamente

# rplace  entrypoint script and replace Odoo configuration file (new name)
ENV RESOURCES /opt/odoo/resources/
COPY ./resources/ ${RESOURCES}
RUN chown -R odoo ${RESOURCES}

# change entrypoint
ENTRYPOINT ["/opt/odoo/resources/entrypoint.sh"]
CMD ["odoo.py"]

# Variables used by the launch scripts
ENV \
    ODOO_SERVER=odoo.py \
    ODOO_CONF=/opt/odoo/etc/odoo.conf \
    # odoo conf variables
    UNACCENT=True \
    PGUSER=odoo \
    PGPASSWORD=odoo \
    PGHOST=db \
    WORKERS=6 \
    ADMIN_PASSWORD=admin \
    SERVER_MODE=test \
    PROXY_MODE=True \
    WITHOUT_DEMO=True \
    DB_MAXCONN=32 \
    LIMIT_TIME_CPU=60 \
    LIMIT_TIME_REAL=120 \
    AEROO_DOCS_HOST=aeroo \
    AFIP_HOMO_PKEY_FILE=/opt/odoo/backups/homo.pkey \
    AFIP_HOMO_CERT_FILE=/opt/odoo/backups/homo.cert \
    AFIP_PROD_PKEY_FILE=/opt/odoo/backups/prod.pkey \
    AFIP_PROD_CERT_FILE=/opt/odoo/backups/prod.cert \
    DB_TEMPLATE=template1

# odoo server use this env var as default conf, check if v9 or v10 rename it
ENV OPENERP_SERVER $ODOO_CONF

USER odoo

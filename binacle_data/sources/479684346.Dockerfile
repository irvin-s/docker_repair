FROM adhoc/odoo-oca:11.0
MAINTAINER Juan Jose Scarafia <jjs@adhoc.com.ar>

USER root

# Get repositories & add files
WORKDIR ${RESOURCES}
COPY ./adhoc-sources.txt ./
RUN mkdir -p ${EXTRA_ADDONS}
RUN python3 get_addons.py ${EXTRA_ADDONS} --depth=1 --sources_file=adhoc-sources.txt
WORKDIR /

# para pyafipws
# TODO activar
# RUN chmod 777 -R /usr/local/lib/python3/dist-packages/pyafipws/

# seteamos SERVER_WIDE_MODULES de los modulos incluidos
ENV SERVER_WIDE_MODULES web,server_mode,database_tools,

USER odoo

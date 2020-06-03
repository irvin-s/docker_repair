FROM adhoc/odoo-base:11.0
MAINTAINER Juan Jose Scarafia <jjs@adhoc.com.ar>

USER root

# Get repositories & add files
WORKDIR ${RESOURCES}
COPY ./oca-sources.txt ./
RUN mkdir -p ${EXTRA_ADDONS}
RUN python3 get_addons.py ${EXTRA_ADDONS} --depth=1 --sources_file=oca-sources.txt

WORKDIR /
USER odoo

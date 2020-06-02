FROM adhoc/odoo-all-in-one:8.0  
MAINTAINER Juan Jose Scarafia <jjs@adhoc.com.ar>  
  
# Create directories for addons and odoo data  
ENV SOURCES_DIR /opt/odoo/sources  
ENV EXTRA_ADDONS /opt/odoo/extra-addons  
ENV DATA_DIR /opt/odoo/data  
RUN mkdir -m a+rw -p ${SOURCES_DIR}  
RUN mkdir -m a+rw -p ${DATA_DIR}  
RUN mkdir -m a+rw -p ${EXTRA_ADDONS}  
  
# Get repositories & add files  
WORKDIR SOURCES_DIR  
ADD resources/modules_to_install.txt ./  
ADD resources/config_odoo.py ./  
ADD resources/get_addons.py ./  
ADD resources/sources.txt ./  
RUN python get_addons.py ${EXTRA_ADDONS}  
RUN python config_odoo.py ${EXTRA_ADDONS} ${SOURCES_DIR}  
WORKDIR /  
  
# Enable aeroo  
RUN sed -i "\$aaeroo.docs_enabled = True" /etc/odoo/openerp-server.conf  


FROM adhoc/odoo-ar:8.0
MAINTAINER Juan Jose Scarafia <jjs@adhoc.com.ar>

USER root

RUN apt-get update
# ADD YOUR CUSTOM COMMANDS

USER odoo

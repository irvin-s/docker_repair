FROM hadim/omero-base:1.0.4

MAINTAINER hadrien.mary@gmail.com

USER omero

# Path variables
ENV OMERO_DATA_DIR /data/omero_data
ENV OMERO_VAR_DIR /data/omero_var
ENV OMERO_SCRIPTS_DIR /data/omero_scripts

# Default password for admin user (root) of OMERO.server
ENV PASSWORD password

COPY start.sh /start.sh
COPY init.sh /init.sh

EXPOSE 4064

CMD ["bash", "/start.sh"]

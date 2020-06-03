MAINTAINER Selion <selion@googlegroups.com>

USER root

#====================================
# Scripts to run Standalone
#====================================
COPY entry_point.sh $SELION_HOME/entry_point.sh
RUN chmod +x $SELION_HOME/entry_point.sh

#==========================================
# Don't need this file from the base image
#==========================================
RUN rm $SELION_HOME/config.json

USER seluser

EXPOSE 4444

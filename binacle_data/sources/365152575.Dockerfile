MAINTAINER Selion <selion@googlegroups.com>

USER root

#=========
# Firefox
#=========
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    firefox \
  && rm -rf /var/lib/apt/lists/*

#========================
# Selenium Configuration
#========================
COPY config.json $SELION_HOME/config.json

RUN chown -R seluser $SELION_HOME
USER seluser

FROM alpine:3.7
MAINTAINER Minium Team <minium@vilt-group.com>

ARG SELENIUM_GRID_EXTRAS_VERSION=2.0.4
ENV PATH_TO_SELENIUM /opt/selenium

RUN apk add --no-cache \
        bash \
        wget \
        ca-certificates \
        openjdk8-jre \
    && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/java.security

#============================
# Selenium Grid Extras
#============================
RUN  mkdir -p $PATH_TO_SELENIUM \
  && wget https://github.com/groupon/Selenium-Grid-Extras/releases/download/v$SELENIUM_GRID_EXTRAS_VERSION/SeleniumGridExtras-$SELENIUM_GRID_EXTRAS_VERSION-SNAPSHOT-jar-with-dependencies.jar -O $PATH_TO_SELENIUM/selenium-grid-extras.jar
  
#====================================
# Scripts to run Selenium Grid Extras
#====================================
COPY entry_point.sh /opt/bin/
COPY log4j.properties $PATH_TO_SELENIUM/log4j.properties
RUN chmod +x /opt/bin/entry_point.sh
ADD hub_4444.json $PATH_TO_SELENIUM/hub_4444.json
ADD selenium_grid_extras_config.json $PATH_TO_SELENIUM/selenium_grid_extras_config.json

EXPOSE 4444 3000

WORKDIR "$PATH_TO_SELENIUM"
CMD "/opt/bin/entry_point.sh"
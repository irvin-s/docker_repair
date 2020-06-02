FROM selenium/node-chrome-debug:2.44.0

RUN ls /

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
COPY config.json /opt/selenium/config.json

EXPOSE 5900
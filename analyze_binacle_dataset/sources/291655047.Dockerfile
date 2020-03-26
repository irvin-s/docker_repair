FROM minium/selenium-grid-extras-base:2.0.4
LABEL maintainer="Minium Team <minium@vilt-group.com>"

#============================================
# Firefox
#============================================
ARG FIREFOX_VERSION=63.0
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install bzip2 firefox \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && wget --no-verbose -O /tmp/firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2 \
  && apt-get -y purge firefox \
  && rm -rf /opt/firefox \
  && tar -C /opt -xjf /tmp/firefox.tar.bz2 \
  && rm /tmp/firefox.tar.bz2 \
  && mv /opt/firefox /opt/firefox-$FIREFOX_VERSION \
  && ln -fs /opt/firefox-$FIREFOX_VERSION/firefox /usr/bin/firefox

#Add Node Configuration
ADD node_firefox.json $PATH_TO_SELENIUM/node_5555.json
ADD selenium_grid_extras_config_firefox.json $PATH_TO_SELENIUM/selenium_grid_extras_config.json

EXPOSE 5555 3000
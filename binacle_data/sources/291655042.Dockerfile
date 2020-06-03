FROM minium/selenium-grid-extras-base:2.0.4
LABEL maintainer="Minium Team <minium@vilt-group.com>"

#============================================
# Google Chrome
#============================================
ARG CHROME_VERSION="google-chrome-stable"
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install ${CHROME_VERSION:-google-chrome-stable} \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#=================================
# Google Chrome Launch Script
#=================================
COPY chrome_launcher.sh /opt/google/chrome/google-chrome
RUN chmod +x /opt/google/chrome/google-chrome

#Add Node Configuration
ADD node_chrome.json $PATH_TO_SELENIUM/node_5555.json
ADD selenium_grid_extras_config_chrome.json $PATH_TO_SELENIUM/selenium_grid_extras_config.json

EXPOSE 5555 3000
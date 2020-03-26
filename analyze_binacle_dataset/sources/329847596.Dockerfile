# Copyright (C) 2019 Google Inc.
# Licensed under http://www.apache.org/licenses/LICENSE-2.0 <see LICENSE file>

ARG CHROME_CT_VERSION="3.141.59-copernicium"
FROM selenium/standalone-chrome:${CHROME_CT_VERSION}

USER root
COPY ./provision/docker/selenium.bashrc.j2 /root/.bashrc
RUN apt-get update && apt-get install -y python python-pip python-setuptools

COPY ./src/requirements-selenium.txt /tmp/requirements.txt
RUN pip install pip \
  && pip install -r /tmp/requirements.txt

RUN usermod -u 1000 seluser

WORKDIR /selenium
USER seluser

# Specify version of Chrome webdriver using 'CHROME_DRIVER_VERSION' argument
# Latest released version will be used by default
ARG CHROME_DRIVER_VERSION="2.45"
RUN CD_VER=$(if [ ${CHROME_DRIVER_VERSION:-latest} = "latest" ]; then echo\
  $(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE); \
  else echo $CHROME_DRIVER_VERSION; fi) \
  && echo "Using chromedriver version: "$CD_VER \
  && wget --no-verbose -O /tmp/chromedriver_linux64.zip \
  https://chromedriver.storage.googleapis.com/$CD_VER/chromedriver_linux64.zip\
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CD_VER\
  && chmod 755 /opt/selenium/chromedriver-$CD_VER \
  && sudo ln -fs /opt/selenium/chromedriver-$CD_VER /usr/bin/chromedriver

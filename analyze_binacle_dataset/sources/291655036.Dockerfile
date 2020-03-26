FROM ubuntu:16.04
LABEL maintainer="Minium Team <minium@vilt-group.com>"

ARG SELENIUM_GRID_EXTRAS_VERSION=2.0.4
ENV PATH_TO_SELENIUM /opt/selenium

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV SCREEN_WIDTH 1440
ENV SCREEN_HEIGHT 900
ENV SCREEN_DEPTH 24
ENV DISPLAY :99
# Fixes https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null


RUN  echo "deb http://archive.ubuntu.com/ubuntu xenial main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu xenial-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu xenial-security main universe\n" >> /etc/apt/sources.list


RUN apt-get update -qqy 
RUN apt-get -qqy --no-install-recommends install lsof feh tzdata ca-certificates openjdk-8-jdk-headless unzip dbus-x11 wget xvfb fluxbox 
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security


#===================
# Timezone settings
# Possible alternative: https://github.com/docker/docker/issues/3359#issuecomment-32150214
#===================
ENV TZ "UTC"
RUN echo "${TZ}" > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

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
COPY init_fluxbox /root/.fluxbox/init 
COPY bg.jpg /usr/share/images/fluxbox/ubuntu-light.png
RUN chmod +x /opt/bin/entry_point.sh

EXPOSE 5555 3000

WORKDIR "$PATH_TO_SELENIUM"
CMD "/opt/bin/entry_point.sh"

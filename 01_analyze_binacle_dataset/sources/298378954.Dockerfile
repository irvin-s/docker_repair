FROM qa.stratio.com/stratio/ubuntu-base:16.04
MAINTAINER Stratio QA team "qa@stratio.com"
ARG VERSION

ADD http://tools.stratio.com/selenium/selenium-server-standalone-3.0.1.jar /tmp/selenium-server-standalone-3.0.1.jar
ADD http://tools.stratio.com/selenium/chromedriver-2.27 /tmp/chromedriver

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install google-chrome-stable xvfb x11vnc \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/*

RUN chmod a+x /tmp/chromedriver

ENV DBUS_SESSION_BUS_ADDRESS /dev/null

EXPOSE 5900
EXPOSE 4444
EXPOSE 5555

ENTRYPOINT [ "/docker-entrypoint.sh" ]

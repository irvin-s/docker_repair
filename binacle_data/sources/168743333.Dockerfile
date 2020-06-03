FROM ubuntu:14.04
MAINTAINER Daniel Rodriguez

RUN apt-get -y update && apt-get install -y \
    unzip \
    curl \
    openjdk-7-jre-headless \
    xvfb \
    fonts-ipafont-gothic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-scalable \
    xfonts-cyrillic

# Install Chrome
RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub -o /tmp/google.pub
RUN cat /tmp/google.pub | apt-key add -; rm /tmp/google.pub
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google.list
RUN mkdir -p /usr/share/desktop-directories
RUN apt-get -y update && apt-get install -y google-chrome-stable

# Disable the SUID sandbox so that chrome can launch without being in a privileged container
RUN dpkg-divert --add --rename --divert /opt/google/chrome/google-chrome.real /opt/google/chrome/google-chrome
RUN echo "#!/bin/bash\nexec /opt/google/chrome/google-chrome.real --disable-setuid-sandbox \"\$@\"" > /opt/google/chrome/google-chrome
RUN chmod 755 /opt/google/chrome/google-chrome

# Install selenium
RUN mkdir -p /opt/selenium
RUN curl http://selenium-release.storage.googleapis.com/2.48/selenium-server-standalone-2.48.2.jar -o /opt/selenium/selenium-server-standalone.jar

# Install Chrome Driver
RUN curl http://chromedriver.storage.googleapis.com/2.20/chromedriver_linux64.zip -o /opt/selenium/chromedriver_linux64.zip
RUN cd /opt/selenium; unzip /opt/selenium/chromedriver_linux64.zip; rm -rf chromedriver_linux64.zip;

ENV DISPLAY :20
COPY entrypoint.sh /opt/selenium/entrypoint.sh

EXPOSE 4444
CMD ["sh", "/opt/selenium/entrypoint.sh"]

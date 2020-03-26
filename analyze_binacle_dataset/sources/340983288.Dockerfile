# BUILD-USING $ docker build -t tildedave/nightwatch-xvfb-firefox .

FROM java:8-jre

## Node.js setup
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs

## Firefox w/xvfb
RUN \
    echo 'deb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main' > /etc/apt/sources.list.d/ubuntuzilla.list && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C1289A29 && \
    apt-get update && \
    apt-get install -y firefox xvfb dbus-x11 libfontconfig1 libxcomposite1 libasound2 libdbus-glib-1-2 libgtk2.0 && \
    rm -rf /var/lib/apt/lists/*

## Nightwatch
RUN npm install -g nightwatch
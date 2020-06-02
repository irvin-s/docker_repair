FROM ubuntu:14.04
MAINTAINER Kevin Smyth <kevin.m.smyth@gmail.com>

RUN apt-get -qq update && apt-get install -y --no-install-recommends apt-transport-https ca-certificates
RUN printf 'deb https://deb.nodesource.com/node_0.12/ trusty main\n' > /etc/apt/sources.list.d/nodesource-trusty.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 68576280

RUN apt-get -qq update && sudo apt-get install -y --no-install-recommends curl wget unzip build-essential openjdk-7-jdk git-core nodejs xvfb firefox python moreutils ca-certificates
RUN apt-get install -y x11vnc

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/

RUN npm install -g npm@2.14.1 && npm install -g protractor@2.2.0
RUN webdriver-manager update --standalone

RUN echo Xvfb :99 -ac -screen 0 1024x768x24 \& > /etc/init.d/xvfb

ENV DISPLAY=":99.0"

# 2/5/2015 firefox-35 + protractor is broken! use firefox-34
#RUN curl -f -s -S http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/34.0/linux-x86_64/en-US/firefox-34.0.tar.bz2 | tar xj --directory / && dpkg --remove firefox
#ENV PATH="/firefox:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

#VOLUME ["/mms-webcyphy"]
WORKDIR /mms-webcyphy

# docker build -t mms-webcyphy-protractor protractor
# docker kill mms-webcyphy-protractor ; docker rm mms-webcyphy-protractor
# docker run --rm -p 5900:5900 --name mms-webcyphy-protractor --volumes-from mms-webcyphy --link mms-webcyphy:mms-webcyphy --link component-server:component-server -t mms-webcyphy-protractor bash test/protractor/docker-script.sh --vnc


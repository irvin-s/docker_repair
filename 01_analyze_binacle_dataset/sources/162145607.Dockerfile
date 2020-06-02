FROM debian:wheezy
MAINTAINER Sam Minnee <sam@silverstripe.com>

### SET UP

# BASE wheezy-backports O/S with some helpful tools
RUN echo "deb http://ftp.us.debian.org/debian wheezy-backports main" >> /etc/apt/sources.list
RUN apt-get -qq update
RUN apt-get -qqy install sudo wget lynx telnet nano curl

# JAVA and XVFB
RUN apt-get -qqy install openjdk-7-jre xvfb x11vnc
RUN apt-get -qqy install ratpoison ffmpeg iceweasel

# Selenium
RUN mkdir /usr/local/selenium
RUN cd /usr/local/selenium && wget http://selenium-release.storage.googleapis.com/2.39/selenium-server-standalone-2.39.0.jar

ADD start-selenium /usr/local/bin/start-selenium
ADD stream-mkv /usr/local/bin/stream-mkv

# Expose selenium and VNC ports
EXPOSE 4444
EXPOSE 5900

# Start XVFB and Selenium
WORKDIR /usr/local/selenium
CMD ["start-selenium"]
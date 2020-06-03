FROM ubuntu:14.04 

MAINTAINER Emmanuel Peroumalnaik "eperoumalnaik@weborama.com"

# add security package sources so that we have the latest version of libnss ( required from google-chrome )

RUN echo deb http://security.ubuntu.com/ubuntu trusty-security main restricted >> /etc/apt/sources.list
RUN echo deb-src http://security.ubuntu.com/ubuntu trusty-security main restricted >> /etc/apt/sources.list
RUN echo deb http://security.ubuntu.com/ubuntu trusty-security universe >> /etc/apt/sources.list
RUN echo deb-src http://security.ubuntu.com/ubuntu trusty-security universe >> /etc/apt/sources.list
RUN echo deb http://security.ubuntu.com/ubuntu trusty-security multiverse >> /etc/apt/sources.list
RUN echo deb-src http://security.ubuntu.com/ubuntu trusty-security multiverse >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y -q wget unzip dpkg libnss3-1d
RUN wget --no-check-certificate -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
ADD http://chromedriver.storage.googleapis.com/2.13/chromedriver_linux64.zip /srv/
RUN unzip /srv/chromedriver_linux64.zip -d /srv
RUN echo deb http://dl.google.com/linux/chrome/deb/ stable main >> /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update
RUN apt-get install -q -y openjdk-7-jre-headless google-chrome-stable xvfb

ADD ./install /
ADD http://selenium-release.storage.googleapis.com/2.44/selenium-server-standalone-2.44.0.jar /srv/

EXPOSE 4444

CMD ["/usr/local/bin/start-selenium-server.sh"]

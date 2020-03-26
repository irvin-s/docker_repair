MAINTAINER Selion <selion@googlegroups.com>

ENV PJS_VERSION 2.1.1

USER root

#==============
# PhantomJS
#==============
RUN apt-get update -y
RUN apt-get install bzip2 libfreetype6 libfontconfig1 -y
COPY deps/* /
RUN tar -xvjf phantomjs-$PJS_VERSION-linux-x86_64.tar.bz2 && rm phantomjs-$PJS_VERSION-linux-x86_64.tar.bz2
RUN mv /phantomjs-$PJS_VERSION-linux-x86_64 /usr/local/phantomjs-$PJS_VERSION-linux-x86_64
RUN ln -s /usr/local/phantomjs-$PJS_VERSION-linux-x86_64/bin/phantomjs $SELION_HOME/phantomjs

#========================
# Selenium Configuration
#========================
COPY config.json $SELION_HOME/config.json

RUN chown -R seluser $SELION_HOME
USER seluser

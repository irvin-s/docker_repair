FROM ubuntu:16.04
MAINTAINER Julian Seeger <seeger@qabel.de>

RUN dpkg --add-architecture i386 && \
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections  && \
    apt-get update -y && \
    apt-get install -yqf \
        wine \
        unzip \
        unp \
        && \
    apt-get clean

RUN apt-get update -y && apt-get install -yqf \
    xvfb

RUN apt-get update -y && \
    apt-get install -yqf \
        python-software-properties \
        software-properties-common && \
    apt-add-repository -y ppa:webupd8team/java && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
    apt-get update -y && \
    apt-get install -yqf oracle-java8-installer

RUN apt-get update -y && \
    apt-get install -yqf \
        git && \
    apt-get clean

RUN useradd -ms /bin/bash vagrant
USER vagrant

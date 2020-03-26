FROM nimmis/ubuntu:16.04

MAINTAINER nimmis <kjell.havneskold@gmail.com>

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

# set default java environment variable
ENV JAVA_VERSION_MAJOR=7 \
    JAVA_VERSION_MINOR=95 \
    JAVA_HOME=/usr/lib/jvm/default-jvm \
    PATH=${PATH}:/usr/lib/jvm/default-jvm/bin/

RUN add-apt-repository ppa:openjdk-r/ppa -y && \

    # update data from repositories
    apt-get update && \
    
    # upgrade OS
    apt-get -y dist-upgrade && \

    # Make info file about this build
    printf "Build of nimmis/java:openjdk-7-jre-headless, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` > /etc/BUILDS/java && \

    # install applications
    apt-get install -y --no-install-recommends openjdk-7-jre-headless && \

    # fix default setting
    ln -s java-7-openjdk-amd64  /usr/lib/jvm/default-jvm && \

    # remove apt cache from image
    apt-get clean all



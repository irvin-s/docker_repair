FROM nimmis/ubuntu:16.04

MAINTAINER nimmis <kjell.havneskold@gmail.com>

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

# set default java environment variable
ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=121 \
    JAVA_HOME=/usr/lib/jvm/default-jvm \
    PATH=${PATH}:/usr/lib/jvm/default-jvm/bin/

RUN add-apt-repository ppa:webupd8team/java -y && \

    # make installation not to ask
    echo debconf shared/accepted-oracle-license-v1-1 select true |  debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true |  debconf-set-selections && \

    # update data from repositories
    apt-get update && \
    
    # upgrade OS
    apt-get -y dist-upgrade && \

    # Make info file about this build
    printf "Build of nimmis/java:oracle-8-jdk, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` > /etc/BUILDS/java && \

    # install java
    apt-get install -y --no-install-recommends oracle-java8-installer && \
    apt-get install -y --no-install-recommends oracle-java8-set-default && \

    # remove download
    rm -rf /var/cache/oracle-jdk8-installer && \

    # fix default setting
    ln -s java-8-oracle  /usr/lib/jvm/default-jvm && \

    # remove apt cache from image
    apt-get clean all

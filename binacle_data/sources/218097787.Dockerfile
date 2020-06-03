FROM anapsix/alpine-java:jdk7

USER root

#####
# Ant
#####

# Preparation

ENV ANT_VERSION 1.9.7
ENV ANT_HOME /etc/ant-${ANT_VERSION}

# Installation

RUN cd /tmp \
    && wget http://www.us.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz \
    && mkdir ant-${ANT_VERSION} \
    && tar -zxvf apache-ant-${ANT_VERSION}-bin.tar.gz \
    && mv apache-ant-${ANT_VERSION} ${ANT_HOME} \
    && rm apache-ant-${ANT_VERSION}-bin.tar.gz \
    && rm -rf ant-${ANT_VERSION} \
    && rm -rf ${ANT_HOME}/manual \
    && unset ANT_VERSION
ENV PATH ${PATH}:${ANT_HOME}/bin

#############
# Ant Contrib
#############

# Preparation

ENV ANT_CONTRIB_VERSION 1.0b2

# Installation

RUN cd /tmp \
    && wget http://kent.dl.sourceforge.net/project/ant-contrib/ant-contrib/ant-contrib-${ANT_CONTRIB_VERSION}/ant-contrib-${ANT_CONTRIB_VERSION}-bin.tar.gz \
    && tar -zxvf ant-contrib-${ANT_CONTRIB_VERSION}-bin.tar.gz \
    && cp ant-contrib/lib/ant-contrib.jar ${ANT_HOME}/lib \
    && rm -rf ant-contrib \
    && rm ant-contrib-${ANT_CONTRIB_VERSION}-bin.tar.gz \
    && unset ANT_CONTRIB_VERSION


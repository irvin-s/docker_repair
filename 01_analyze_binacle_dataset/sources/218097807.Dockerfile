FROM inikolaev/jdk:latest

USER root

#####
# Ant
#####

# Preparation

ENV ANT_VERSION 1.9.7
ENV ANT_HOME /etc/ant-${ANT_VERSION}

# Installation

RUN cd /tmp \
    && /apt-install wget \
    && wget http://www.us.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz \
    && /apt-remove wget \
    && mkdir ant-${ANT_VERSION} \
    && tar -zxvf apache-ant-${ANT_VERSION}-bin.tar.gz --directory ant-${ANT_VERSION} --strip-components=1 \
    && mv ant-${ANT_VERSION} ${ANT_HOME} \
    && rm apache-ant-${ANT_VERSION}-bin.tar.gz \
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
    && /apt-install wget \
    && wget http://kent.dl.sourceforge.net/project/ant-contrib/ant-contrib/ant-contrib-${ANT_CONTRIB_VERSION}/ant-contrib-${ANT_CONTRIB_VERSION}-bin.tar.gz \
    && /apt-remove wget \
    && mkdir ant-contrib-${ANT_CONTRIB_VERSION} \
    && tar -zxvf ant-contrib-${ANT_CONTRIB_VERSION}-bin.tar.gz --directory ant-contrib-${ANT_CONTRIB_VERSION} --strip-components=1 \
    && cp ant-contrib-${ANT_CONTRIB_VERSION}/lib/ant-contrib.jar ${ANT_HOME}/lib \
    && rm -rf ant-contrib-${ANT_CONTRIB_VERSION} \
    && rm ant-contrib-${ANT_CONTRIB_VERSION}-bin.tar.gz \
    && unset ANT_CONTRIB_VERSION

#########
# Testing
#########

RUN env
RUN java -version
RUN javac -version
RUN ant -version


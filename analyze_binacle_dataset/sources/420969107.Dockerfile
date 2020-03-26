FROM cwds/javajdk

ENV DEBIAN_FRONTEND noninteractive
ENV JMETER_VERSION 3.3
ENV JMETER_HOME /opt/jmeter
ENV JMETER_DOWNLOAD_URL  https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

ENV TEST_PATH /integrationTest
ENV JPGC_JSON_PLUGIN_FILE jpgc-json-2.6.zip
ENV JPGC_JSON_PLUGIN_DOWNLOAD_URL https://jmeter-plugins.org/files/packages/${JPGC_JSON_PLUGIN_FILE}

RUN yum -y install wget
RUN yum -y install unzip
RUN mkdir -p ${JMETER_HOME} \
    && cd ${JMETER_HOME} \
    && wget ${JMETER_DOWNLOAD_URL} \
    && tar -xvzf apache-jmeter-${JMETER_VERSION}.tgz \
    && rm apache-jmeter-${JMETER_VERSION}.tgz

WORKDIR ${JMETER_HOME}

RUN wget ${JPGC_JSON_PLUGIN_DOWNLOAD_URL} \
    && unzip -o -d ${JMETER_HOME}/ ${JMETER_HOME}/${JPGC_JSON_PLUGIN_FILE} \
    && rm ${JMETER_HOME}/${JPGC_JSON_PLUGIN_FILE}

RUN mkdir -p $TEST_PATH
WORKDIR $TEST_PATH

COPY src/test/resources/jmeter/ jmeterTests/

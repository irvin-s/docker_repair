FROM centos:7 as artemis-base-broker
MAINTAINER Otavio Rodolfo Piske <angusyoung@gmail.com>
ARG ARTEMIS_VERSION
ENV ARTEMIS_VERSION ${ARTEMIS_VERSION:-2.6.3}
ARG ARTEMIS_JOURNAL
ENV ARTEMIS_JOURNAL ${ARTEMIS_JOURNAL:-aio}
ENV MAESTRO_SUT_ROOT /opt/maestro/sut/
ENV MAESTRO_DATA_ROOT /maestro
VOLUME /maestro
EXPOSE 1883
RUN yum install -y java-1.8.0-openjdk libaio && yum clean all
ENV JAVA_HOME /etc/alternatives/jre
RUN mkdir -p ${MAESTRO_SUT_ROOT}
WORKDIR ${MAESTRO_SUT_ROOT}
RUN curl https://archive.apache.org/dist/activemq/activemq-artemis/${ARTEMIS_VERSION}/apache-artemis-${ARTEMIS_VERSION}-bin.tar.gz -o apache-artemis.tar.gz && \
    mkdir -p apache-artemis && tar --strip-components=1 -xvf apache-artemis.tar.gz -C apache-artemis && \
    rm -f apache-artemis.tar.gz

FROM artemis-base-broker
RUN ${MAESTRO_SUT_ROOT}/apache-artemis/bin/artemis create --${ARTEMIS_JOURNAL} --allow-anonymous --http-host 0.0.0.0 --user admin --password "admin" --role amq --data ${MAESTRO_DATA_ROOT} ${MAESTRO_SUT_ROOT}/apache-artemis-instance
ADD jolokia-access.xml ${MAESTRO_SUT_ROOT}/apache-artemis-instance/etc/jolokia-access.xml
CMD [ "sh", "-c", "./apache-artemis-instance/bin/artemis run" ]

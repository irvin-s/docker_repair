FROM centos:7 as artemis-base
MAINTAINER Otavio Rodolfo Piske <angusyoung@gmail.com>
ARG ARTEMIS_VERSION
ENV ARTEMIS_VERSION ${ARTEMIS_VERSION:-2.6.3}
ARG ARTEMIS_JOURNAL
ENV ARTEMIS_JOURNAL ${ARTEMIS_JOURNAL:-aio}
ENV MAESTRO_SUT_ROOT /opt/maestro/sut/
ENV MAESTRO_DATA_ROOT /maestro
VOLUME /maestro
EXPOSE 5672 8161 61613 61616
RUN yum install -y java-1.8.0-openjdk libaio && yum clean all
ENV JAVA_HOME /etc/alternatives/jre
RUN mkdir -p ${MAESTRO_SUT_ROOT}
WORKDIR ${MAESTRO_SUT_ROOT}
RUN curl https://archive.apache.org/dist/activemq/activemq-artemis/${ARTEMIS_VERSION}/apache-artemis-${ARTEMIS_VERSION}-bin.tar.gz -o apache-artemis.tar.gz && \
    mkdir -p apache-artemis && tar --strip-components=1 -xvf apache-artemis.tar.gz -C apache-artemis && \
    rm -f apache-artemis.tar.gz

FROM artemis-base as artemis
RUN ${MAESTRO_SUT_ROOT}/apache-artemis/bin/artemis create --${ARTEMIS_JOURNAL} --allow-anonymous --http-host 0.0.0.0 --user admin --password "admin" --role amq --data ${MAESTRO_DATA_ROOT} ${MAESTRO_SUT_ROOT}/apache-artemis-instance
ADD jolokia-access.xml ${MAESTRO_SUT_ROOT}/apache-artemis-instance/etc/jolokia-access.xml
CMD [ "sh", "-c", "./apache-artemis-instance/bin/artemis run" ]

FROM artemis-base as artemis-tls
RUN ${MAESTRO_SUT_ROOT}/apache-artemis/bin/artemis create --${ARTEMIS_JOURNAL} --allow-anonymous --http-host 0.0.0.0 --user admin --password "admin" --role amq --data ${MAESTRO_DATA_ROOT} ${MAESTRO_SUT_ROOT}/apache-artemis-instance
RUN keytool -genkey -keystore server-side-keystore.jks -storepass maestro -keypass maestro -dname "CN=ActiveMQ Artemis Server, OU=Artemis, O=ActiveMQ, L=AMQ, S=AMQ, C=AMQ" -keyalg RSA
RUN keytool -export -keystore server-side-keystore.jks -file server-side-cert.cer -storepass maestro
RUN sed -i 's/<\/acceptor>/;sslEnabled=true;keyStorePath=\/opt\/maestro\/sut\/server-side-keystore.jks;keyStorePassword=maestro<\/acceptor>/' ${MAESTRO_SUT_ROOT}/apache-artemis-instance/etc/broker.xml
ADD jolokia-access.xml ${MAESTRO_SUT_ROOT}/apache-artemis-instance/etc/jolokia-access.xml
CMD [ "sh", "-c", "./apache-artemis-instance/bin/artemis run" ]

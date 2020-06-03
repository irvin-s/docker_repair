FROM centos:7
MAINTAINER Otavio Rodolfo Piske <angusyoung@gmail.com>
ARG ACTIVEMQ_VERSION
ENV ACTIVEMQ_VERSION ${ACTIVEMQ_VERSION:-5.15.3}
ENV MAESTRO_APP_ROOT /opt/maestro/broker
EXPOSE 8161
EXPOSE 1883 
RUN yum install -y java-1.8.0-openjdk && yum clean all
ENV JAVA_HOME /etc/alternatives/jre
RUN mkdir -p ${MAESTRO_APP_ROOT}
WORKDIR ${MAESTRO_APP_ROOT}
RUN curl https://archive.apache.org/dist/activemq/${ACTIVEMQ_VERSION}/apache-activemq-${ACTIVEMQ_VERSION}-bin.tar.gz -o apache-activemq.tar.gz && \
    mkdir -p apache-activemq && tar --strip-components=1 -xvf apache-activemq.tar.gz -C apache-activemq && \
    rm -f apache-activemq.tar.gz
CMD [ "sh", "-c", "./apache-activemq/bin/activemq console" ]
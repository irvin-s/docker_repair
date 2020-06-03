FROM bigm/base-jdk8

#= rundeck
ENV RUNDECK_VERSION 2.5.0
ENV RDECK_BASE /prj/bin/rdeck

RUN mkdir -p $RDECK_BASE \
    && /xt/tools/_download $RDECK_BASE/rundeck-launcher-$RUNDECK_VERSION.jar http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-$RUNDECK_VERSION.jar \
    && ln -s $RDECK_BASE/rundeck-launcher-$RUNDECK_VERSION.jar $RDECK_BASE/rundeck-launcher.jar
# see http://rundeck.org/docs/administration/installation.html#installing-with-launcher
RUN java -XX:MaxPermSize=256m -jar $RDECK_BASE/rundeck-launcher.jar --installonly
ENV PATH $PATH:$RDECK_BASE/tools/bin

ADD supervisor/rundeck.conf /etc/supervisord.d/
ADD startup/rundeck /prj/startup/

ENV RUNDECK_START_URL /
ENV RUNDECK_SERVER_URL ""
ENV RUNDECK_HOSTNAME ""
ENV RUNDECK_INITIAL_PASSWORD rundeckpwd
ENV RUNDECK_FORWARDED false

ENV RUNDECK_DB_URL "jdbc:h2:file:/prj/data/rundeck/data/grailsdb;MVCC=true"
ENV RUNDECK_DB_USER ""
ENV RUNDECK_DB_PASSWORD ""

EXPOSE 4440 4443
VOLUME /prj/data
#= .rundeck

# gerrit
#

FROM ubuntu:trusty

MAINTAINER Larry Cai <larry.caiyu@gmail.com>

ENV GERRIT_USER gerrit2
ENV GERRIT_HOME /home/${GERRIT_USER}
ENV GERRIT_WAR ${GERRIT_HOME}/gerrit.war
ENV GERRIT_VERSION 2.9.3
RUN useradd -m ${GERRIT_USER}

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre-headless git-core vim

ADD https://gerrit-releases.storage.googleapis.com/gerrit-${GERRIT_VERSION}.war /tmp/gerrit.war
ADD . /app

RUN mv /tmp/gerrit.war $GERRIT_WAR
RUN chown -R ${GERRIT_USER}:${GERRIT_USER} $GERRIT_HOME

USER $GERRIT_USER
WORKDIR $GERRIT_HOME

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre
RUN java -jar $GERRIT_WAR init --batch -d ${GERRIT_HOME}/gerrit

# clobber the gerrit config. set the URL to localhost:8080
ADD gerrit.config $GERRIT_HOME/gerrit/etc/gerrit.config

# https://gerrit-documentation.storage.googleapis.com/Documentation/2.9.3/config-gerrit.html#auth
# ENV AUTH_TYPE OpenID

ENV AUTH_TYPE DEVELOPMENT_BECOME_ANY_ACCOUNT

EXPOSE 8080 29418
CMD ["/app/start.sh"]

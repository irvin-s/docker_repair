FROM jenkins:weekly

ADD init/*.groovy /usr/share/jenkins/init.groovy.d/

USER root

RUN apt-get update && apt-get -y install libsvn1

ADD http://downloads.mesosphere.io/master/debian/7/mesos_0.21.1-1.0.debian77_amd64.deb /tmp/mesos.deb

RUN dpkg -i /tmp/mesos.deb && rm /tmp/mesos.deb

RUN mkdir -p /usr/share/jenkins/plugins && \
    chown -R jenkins /usr/share/jenkins/plugins /usr/share/jenkins/init.groovy.d

ADD plugins.awk plugins.csv /usr/share/jenkins/

RUN awk -f /usr/share/jenkins/plugins.awk /usr/share/jenkins/plugins.csv | sh

ADD jenkins-init.sh /usr/local/bin/jenkins-init.sh

VOLUME ["/var/jenkins_home"]

ENTRYPOINT ["/usr/local/bin/jenkins-init.sh"]
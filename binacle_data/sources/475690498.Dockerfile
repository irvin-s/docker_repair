FROM openshift/jenkins-2-centos7:v3.11
USER root
COPY download-dependencies.sh /usr/local/bin
COPY ./jpi /opt/openshift/plugins
RUN /usr/local/bin/download-dependencies.sh

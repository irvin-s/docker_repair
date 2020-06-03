FROM {{ image_spec("base-tools") }}
MAINTAINER {{ maintainer }}

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64/

COPY {{ render('install_odl.sh.j2') }} /tmp/install_odl.sh

RUN apt-get update && \
    apt-get install  -y -t jessie-backports openjdk-8-jre-headless ca-certificates-java && \
    apt-get install -y openjdk-8-jre libxml-xpath-perl && \
    mkdir /odl &&  cd /odl && \
    sh -ex /tmp/install_odl.sh && \
    apt-get -y purge libxml-xpath-perl && \
    apt-get clean

WORKDIR /odl/

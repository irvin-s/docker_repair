FROM ubuntu:16.04
MAINTAINER Mattias Giese <mattiasgiese@posteo.net>
ARG YED_VERSION=3.18.0.2
ENV YED_VERSION ${YED_VERSION}
COPY entrypoint /
ENTRYPOINT ["/entrypoint"]

# Add a PPA repo that provides Oracle Java.
# Ref: <https://launchpad.net/~webupd8team/+archive/ubuntu/java>.
# Auto-accept the Oracle license.
# Ref: <http://www.webupd8.org/2012/09/install-oracle-java-8-in-ubuntu-via-ppa.html>.
# Finally, install ALL the things
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7B2C3B0889BF5709A105D03AC2518248EEA14886 ;\
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/java.list ;\
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections ;\
    apt-get update ;\
    apt-get -y dist-upgrade ;\
    apt-get -y install libxi-dev libxrender-dev libxtst6 oracle-java8-installer unzip wget ;\
    apt-get autoremove ;\
    rm -rf /var/lib/apt/* ;\
    wget -q --output-document=yed.zip https://www.yworks.com/resources/yed/demo/yEd-${YED_VERSION}.zip && \
    unzip /yed.zip -d /opt/

RUN useradd -m user ;\
    mkdir /work && chown user /work
ENV HOME /home/user
USER user

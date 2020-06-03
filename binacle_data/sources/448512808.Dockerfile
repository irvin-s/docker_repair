FROM ubuntu:trusty

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN apt-get update

# Fake a fuse install
RUN apt-get install -y --force-yes libfuse2
RUN cd /tmp ; apt-get download fuse
RUN cd /tmp ; dpkg-deb -x fuse_* .
RUN cd /tmp ; dpkg-deb -e fuse_*
RUN cd /tmp ; rm fuse_*.deb
RUN cd /tmp ; echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst
RUN cd /tmp ; dpkg-deb -b . /fuse.deb
RUN cd /tmp ; dpkg -i /fuse.deb

RUN apt-get install -y varnish activemq postgresql openjdk-7-jdk nodejs

ADD config /app/config
ADD migration /app/migration
ADD src /app/src
ADD gradle /app/gradle
ADD gradlew /app/gradlew
ADD settings.gradle /app/settings.gradle
ADD build.gradle /app/build.gradle

RUN chmod 0755 /app/config/docker/start.sh
RUN chmod 0755 /app/config/docker/install.sh
RUN /app/config/docker/install.sh

EXPOSE 80

CMD ["/app/config/docker/start.sh"]
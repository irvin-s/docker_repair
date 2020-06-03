FROM java:7
MAINTAINER Matt Fullerton <matt.fullerton@gmail.com>

RUN mkdir /setup
ADD install.sh /setup/install.sh
RUN /setup/install.sh
ENTRYPOINT java -jar /srv/tika-server-1.*-SNAPSHOT.jar -host 0.0.0.0

EXPOSE 9998

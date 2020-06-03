FROM centos:centos7
MAINTAINER Vladimir Krivosheev <develar@gmail.com>

RUN yum -y install unzip
RUN mkdir maps
WORKDIR maps

VOLUME /maps

ENTRYPOINT for NAME in Alps France_North France_South Great_Britain Spain_Portugal Italy Poland Finland Belarus Balkan Czech_Republic; do \
             curl --show-error --location -o $NAME.zip http://www.openandromaps.org/maps/europe/$NAME.zip \
             && unzip -j $NAME.zip "$NAME.map" -d $PWD \
             && unlink $NAME.zip; \
           done; \
           curl --show-error --location -o Germany.zip http://www.openandromaps.org/maps/Germany/Germany.zip \
           && unzip -j Germany.zip "Germany.map" -d $PWD && unlink Germany.zip
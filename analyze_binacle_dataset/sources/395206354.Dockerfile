FROM ubuntu:14.04
MAINTAINER Nitish Goyal <nitishgoyal13 [at] gmail.com>


RUN \
  apt-get clean && apt-get update && apt-get install -y --no-install-recommends software-properties-common \
  && add-apt-repository ppa:webupd8team/java \
  && gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
  && apt-get update \
  && echo debconf shared/accepted-oracle-license-v1-1 select true |  debconf-set-selections \
  && echo debconf shared/accepted-oracle-license-v1-1 seen true |  debconf-set-selections \
  && apt-get install -y --no-install-recommends oracle-java8-installer \
  && apt-get install -y --no-install-recommends curl

EXPOSE 17000
EXPOSE 17001
EXPOSE 5701

VOLUME /var/log/foxtrot-server

ADD config/docker.yml docker.yml
ADD foxtrot-server/target/foxtrot*.jar server.jar
ADD scripts/local_es_setup.sh local_es_setup.sh

CMD sh -c "sleep 15 ; java -jar server.jar initialize docker.yml || true ;  java -Dfile.encoding=utf-8 -jar server.jar server docker.yml"


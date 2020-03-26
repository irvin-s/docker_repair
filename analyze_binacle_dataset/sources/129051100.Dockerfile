FROM java:openjdk-8

MAINTAINER  DBpedia Spotlight Team <dbp-spotlight-developers@lists.sourceforge.net>

RUN apt-get update && apt-get install maven -y && git clone https://github.com/dbpedia-spotlight/model-quickstarter.git && git clone https://github.com/dbpedia-spotlight/wikistatsextractor.git && git clone https://github.com/dbpedia-spotlight/dbpedia-spotlight-model.git && mv dbpedia-spotlight-model dbpedia-spotlight && cd dbpedia-spotlight && mvn clean install && cd /model-quickstarter && ./prepare.sh

SHELL ["/bin/bash", "-c"]

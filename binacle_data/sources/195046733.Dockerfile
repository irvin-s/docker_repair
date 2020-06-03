FROM buildpack-deps:jessie

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update
RUN apt-get install apt-transport-https
RUN apt-get install -y nodejs

RUN apt-key advanced --keyserver keys.gnupg.net --recv-keys 90E9F83F22250DD7

RUN echo "deb https://releases.wikimedia.org/debian jessie-mediawiki main" | tee /etc/apt/sources.list.d/parsoid.list

RUN apt-get update
RUN apt-get install -y parsoid

WORKDIR /etc/mediawiki/parsoid
RUN  sed -i 's/localhost\/w/gcpedia/' config.yaml

EXPOSE 8000

ENTRYPOINT ["/usr/bin/nodejs", "/usr/lib/parsoid/src/bin/server.js", "> /dev/stdout"]

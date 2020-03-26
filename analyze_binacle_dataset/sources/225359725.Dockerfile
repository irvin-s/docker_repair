FROM java:8-jdk
MAINTAINER PubNative Team <team@pubnative.net>

RUN apt-get update -y \
 && apt-get install -y \
                   build-essential \
                   gradle \
                   python \
 && rm -rf /var/lib/apt/lists/*

ENV GOSU_VERSION 1.7

RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
  && groupadd -r airpal && useradd -r -g airpal airpal

ENV GITHUB_ORG=pubnative
ENV BRANCH=devel

ADD https://github.com/$GITHUB_ORG/airpal/archive/$BRANCH.zip /tmp/airpal.zip
RUN unzip /tmp/airpal.zip -d /app && rm /tmp/airpal.zip
ENV AIRPAL_HOME /app/airpal-$BRANCH
WORKDIR /app/airpal-$BRANCH
RUN ./gradlew clean shadowJar
RUN mv reference.example.yml reference.yml

COPY docker-entrypoint.sh /
COPY airpal migrate.sh ./

RUN chmod +x /docker-entrypoint.sh \
 && chmod +x airpal migrate.sh

EXPOSE 8081
EXPOSE 8082

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["./airpal"]

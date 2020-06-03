FROM python:2.7-alpine3.6

# Install JAVA
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u131
ENV JAVA_ALPINE_VERSION 8.131.11-r2

RUN set -x \
	&& apk add --no-cache \
		openjdk8-jre="$JAVA_ALPINE_VERSION" \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]
# End install JAVA

# Install MySql Client
RUN apk add --no-cache mysql-client
# End Install MySql Client

# Clone Wasabi Repo
RUN apk update && apk add git
RUN git clone https://github.com/intuit/wasabi.git

# Install cqlsh for cassandra
RUN pip install cqlsh==5.0.3 && \
    cp /usr/local/bin/cqlsh /usr/local/bin/cqlsh4 && \
    sed -i '/DEFAULT_PROTOCOL_VERSION = 4/c\DEFAULT_PROTOCOL_VERSION = 3' /usr/local/bin/cqlsh

ADD https://oss.sonatype.org/content/repositories/public/com/builtamont/cassandra-migration/0.9/cassandra-migration-0.9-jar-with-dependencies.jar /wasabi/cassandra-migration.jar
RUN cp -R /wasabi/modules/repository-datastax/src/main/resources/com/intuit/wasabi/repository/impl/cassandra/migration /wasabi/mutation

RUN cp /wasabi/bin/docker/schema_migration.sh /wasabi/schema_migration.sh
RUN cp /wasabi/bin/docker/create_keyspace.sh /wasabi/create_keyspace.sh

COPY ./init_script.sh /init_script.sh
RUN chmod +x /init_script.sh

CMD ["/init_script.sh"]
ENTRYPOINT ["/bin/sh"]


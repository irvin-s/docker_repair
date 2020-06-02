FROM solr:6.3.0-alpine

MAINTAINER David Smiley <dsmiley@apache.org>

# Some tweaks to work better in Kontena (also other envs)
COPY kontena-init.sh /docker-entrypoint-initdb.d/

# Add JTS jar which unfortunately must go in WEB-INF/lib/
RUN wget --no-verbose -P server/solr-webapp/webapp/WEB-INF/lib/ https://repo1.maven.org/maven2/com/vividsolutions/jts-core/1.14.0/jts-core-1.14.0.jar

# Add custom HCGA BOP libs
COPY *.jar server/solr-webapp/webapp/WEB-INF/lib/

# Ensure solr home stuff gets persisted
VOLUME /opt/solr/server/solr/
# See https://hub.docker.com/_/solr/
FROM solr:5.3
MAINTAINER Geoffrey Booth <geoffrey.booth@disney.com>

USER root
ENV TERM xterm

# See https://knowledge.opentext.com/knowledge/piroot/medmgt/v160000/medmgt-igd/en/html/jsframe.htm?inst-solr-sep-srv-unix
# Add folder created via `ant create-solr-index` in step 3
# Save it to a test data folder so that we don’t overwrite an index which may already be in the Docker volume mounted on /opt/solr-index
ARG OBJECTS_ROOT_URL

#
# Uncomment the next section once `solr5_otmm.tar.gz` is uploaded to `$OBJECTS_ROOT_URL`:
#

# RUN mkdir --parents /opt/solr-index/ /opt/default-otmmcore/solr-index/ \
# 	&& curl --retry 999 --retry-max-time 0 -C - --show-error --location $OBJECTS_ROOT_URL/opentext-media-management-16.2/solr5_otmm.tar.gz \
# 		| tar --extract --gunzip --strip-components=3 --directory /opt/default-otmmcore/solr-index



# Copy config file that points to that index folder, via instructions step 6
COPY solr.xml /opt/solr/server/solr/solr.xml

# Forward log to Docker log collector, based on https://github.com/nginxinc/docker-nginx/blob/master/mainline/jessie/Dockerfile
RUN mkdir --parents /opt/solr/server/logs \
	&& ln --symbolic --force /dev/stdout /opt/solr/server/logs/solr.log

# Fix permissions
RUN if [ -f /opt/solr-index ]; then chown -R solr:solr /opt/solr-index/; fi
RUN if [ -f /opt/default-otmmcore/solr-index/ ]; then chown -R solr:solr /opt/default-otmmcore/solr-index/; fi
RUN chown -R solr:solr /opt/solr/server/solr/solr.xml

USER solr

COPY configure.sh /docker-entrypoint-initdb.d/configure.sh

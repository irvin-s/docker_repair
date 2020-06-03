# See https://hub.docker.com/_/postgres/
FROM postgres:9.4
MAINTAINER Geoffrey Booth <geoffrey.booth@disney.com>

RUN apt-get update \
	&& apt-get install --yes curl \
	&& apt-get clean

# Configure Postgres per https://knowledge.opentext.com/knowledge/llisapi.dll/Open/62041796 and https://knowledge.opentext.com/knowledge/piroot/medmgt/v160000/medmgt-igd/en/html/pstgrs-db-prep.htm
COPY postgresql.conf /var/lib/postgresql/
COPY pg_hba.conf /var/lib/postgresql/

# The following only run on container initialization, not every restart
COPY initialize-for-opentext-media-management.sh /docker-entrypoint-initdb.d/
COPY set-passwords.sh /docker-entrypoint-initdb.d/

# This will be triggered by our entrypoint.sh, so that a backup is taken on every startup in addition to when cron triggers it
# Be warned, files in /etc/cron.daily should be extensionless: http://askubuntu.com/a/250118/240539
COPY backup.sh /etc/cron.daily/backup-postgres
COPY logrotate.conf /etc/logrotate.d/postgres-backups

COPY create-test-data-archive.sh /docker/
COPY entrypoint.sh /

# Copy in post-installation database dumps to be restored if we’re not installing the apps on start
# They’re not large, so copy both the test database (a few users, a few dozen assets) and the blank immediately-post-install database (just the tsuper user, no assets)
ARG DOCKER_MODE
ARG OBJECTS_ROOT_URL
ENV INSTALLATION_FILES_SNAPSHOT 2017-04-30-17-59
RUN if [ "$DOCKER_MODE" = 'use-installed-files' ]; then \
		echo 'Copying post-install, nearly empty database into the image...' \
		&& curl --retry 999 --retry-max-time 0 -C - --show-error --location $OBJECTS_ROOT_URL/opentext-media-management-16.2-post-install/database-post-opentext-media-management-installation-$INSTALLATION_FILES_SNAPSHOT.sql.gz | gunzip > database-post-opentext-media-management-installation.sql; \
	fi

ENTRYPOINT ["/entrypoint.sh"]

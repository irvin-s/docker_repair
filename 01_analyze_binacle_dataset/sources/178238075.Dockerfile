FROM resilio/sync:latest
LABEL maintainer="Odd E. Ebbesen <oddebb@gmail.com>"

ENV TINI_VERSION 0.18.0
ENV TINI_GPG_KEY 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7

RUN apt-get -qq update \
		&& \
		apt-get -y --no-install-recommends install \
		ca-certificates \
		dirmngr \
		gnupg \
		&& \
		apt-get clean autoclean \
		&& \
		apt-get autoremove -y \
		&& \
		rm -rf /var/lib/{apt,dpkg,cache,log}/

ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static /sbin/tini
ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static.asc /tmp/tini-static.asc

RUN \
		gpg --batch --keyserver hkp://pgp.mit.edu:80 --recv-keys "$TINI_GPG_KEY" || \
		gpg --batch --keyserver hkp://keyserver.pgp.com:80 --recv-keys "$TINI_GPG_KEY" || \
		gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-keys "$TINI_GPG_KEY" || \
		gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$TINI_GPG_KEY"

RUN gpg --verify /tmp/tini-static.asc /sbin/tini
RUN chmod 755 /sbin/tini

ENTRYPOINT ["tini", "-g", "--", "run_sync"]
CMD ["--config", "/mnt/sync/sync.conf"]

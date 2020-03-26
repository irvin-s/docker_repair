FROM centos
LABEL maintainer='Chao QU <mail@quchao.com>'

ARG GOSU_VERSION='1.10'

RUN set -ex; \
    # epel
    #yum -y install epel-release; \
    # keep up-to-date
    yum update -y --exclude=kernel*; \
    # gosu
    readonly ARCH='amd64'; \
    readonly GOSU_URL_BASE='https://github.com/tianon/gosu/releases/download/'; \
	curl -sSL -o /usr/bin/gosu "${GOSU_URL_BASE}${GOSU_VERSION}/gosu-${ARCH}"; \
	curl -sSL -o /tmp/gosu.asc "${GOSU_URL_BASE}${GOSU_VERSION}/gosu-${ARCH}.asc"; \
    # verify the signature
    readonly GPG_KEY_SRV='keys.gnupg.net'; \
    readonly GOSU_GPG_KEY='B42F6819007F00F88E364FD4036A9C25BF357DD4'; \
	readonly GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver "${GPG_KEY_SRV}" --recv-keys "${GOSU_GPG_KEY}"; \
	gpg --batch --verify /tmp/gosu.asc /usr/bin/gosu; \
	rm -r "${GNUPGHOME}" /tmp/gosu.asc; \
	chmod +x /usr/bin/gosu; \
	# cleaning
	yum clean all; \
    rm -rf /tmp/* /var/tmp/*;

ARG RUN_AS_USER
ENV RUN_AS_USER="${RUN_AS_USER:-nutshell}"

RUN set -ex; \
    # a low-privilege user
    groupadd -r "${RUN_AS_USER}"; \
    useradd -M -d /var/empty -s /sbin/nologin -g "${RUN_AS_USER}" -r "${RUN_AS_USER}";

COPY docker-entrypoint.sh entrypoint-utils.sh /usr/local/bin/

RUN set -ex; \
    # use gosu instead
    sed -i 's/su-exec/gosu/' /usr/local/bin/docker-entrypoint.sh; \
    # test flight
	chmod +x /usr/local/bin/docker-entrypoint.sh; \
    # avoid docker's 'Text file busy' issue
	docker-entrypoint.sh /bin/true;

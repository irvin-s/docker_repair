FROM debian:jessie

MAINTAINER Bruno Binet <bruno.binet@helioslite.com>

ENV DEBIAN_FRONTEND noninteractive
ENV SALT_VERSION 2016.11
ENV REFRESHED_AT 2017-01-31

RUN echo "deb http://repo.saltstack.com/apt/debian/8/amd64/${SALT_VERSION} jessie main" > /etc/apt/sources.list.d/salt.list

ADD https://repo.saltstack.com/apt/debian/8/amd64/${SALT_VERSION}/SALTSTACK-GPG-KEY.pub /tmp/SALTSTACK-GPG-KEY.pub
RUN echo "9e0d77c16ba1fe57dfd7f1c5c2130438  /tmp/SALTSTACK-GPG-KEY.pub" | md5sum --check
RUN apt-key add /tmp/SALTSTACK-GPG-KEY.pub

RUN apt-get update && apt-get install -yq --no-install-recommends \
  salt-master reclass salt-api python-apt python-git python-openssl \
  python-cherrypy3 git openssh-client make

ENV MOLTEN_VERSION 0.3.1
ENV MOLTEN_MD5 04483620978a3167827bdd1424e34505
ADD https://github.com/martinhoefling/molten/releases/download/v${MOLTEN_VERSION}/molten-${MOLTEN_VERSION}.tar.gz molten-${MOLTEN_VERSION}.tar.gz
RUN echo "${MOLTEN_MD5}  molten-${MOLTEN_VERSION}.tar.gz" | md5sum --check
RUN mkdir -p /opt/molten && tar -xf molten-${MOLTEN_VERSION}.tar.gz -C /opt/molten --strip-components=1

ADD run.sh /run.sh
RUN chmod a+x /run.sh

# salt-master, salt-api
EXPOSE 4505 4506 443

ENV SALT_CONFIG /etc/salt
ENV BEFORE_EXEC_SCRIPT ${SALT_CONFIG}/before-exec.sh
ENV SALT_API_CMD /usr/bin/salt-api -c ${SALT_CONFIG} -d
ENV EXEC_CMD /usr/bin/salt-master -c ${SALT_CONFIG}  --log-file-level=quiet --log-level=debug

CMD ["/run.sh"]

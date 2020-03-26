FROM centos:7
MAINTAINER Andrea Sosso <andrea@sosso.me>

ENV MAXSCALE_VERSION 2.2.5
ENV MAXSCALE_URL https://downloads.mariadb.com/MaxScale/${MAXSCALE_VERSION}/rhel/7/x86_64/maxscale-${MAXSCALE_VERSION}-1.rhel.7.x86_64.rpm

ONBUILD ENV MAXSCALE_VERSION $MAXSCALE_VERSION
ONBUILD ENV MAXSCALE_URL $MAXSCALE_URL

ONBUILD RUN curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash -s -- --skip-server --skip-tools \
    && yum -y update \
    && yum deplist maxscale | grep provider | awk '{print $2}' | sort | uniq | grep -v maxscale | sed ':a;N;$!ba;s/\n/ /g' | xargs yum -y install \
    && rpm -Uvh ${MAXSCALE_URL} \
    && yum clean all \
    && rm -rf /tmp/*

# Move configuration file in directory for exports and enable maxadmin cli
ONBUILD RUN mkdir -p /etc/maxscale.d \
    && cp /etc/maxscale.cnf.template /etc/maxscale.d/maxscale.cnf \
    && ln -sf /etc/maxscale.d/maxscale.cnf /etc/maxscale.cnf \
    && chown root:maxscale /etc/maxscale.d/maxscale.cnf \
    && chmod g+w /etc/maxscale.d/maxscale.cnf \
    && echo '[{"name": "root", "account": "admin", "password": ""}, {"name": "maxscale", "account": "admin", "password": ""}]' > /var/lib/maxscale/maxadmin-users

# VOLUME for custom configuration
VOLUME ["/etc/maxscale.d"]

USER maxscale

# EXPOSE the MaxScale default ports

## RW Split Listener
EXPOSE 4006

## Read Connection Listener
EXPOSE 4008

## Debug Listener
EXPOSE 4442

## CLI Listener
EXPOSE 6603

# Running MaxScale
ENTRYPOINT ["/usr/bin/maxscale", "-d"]

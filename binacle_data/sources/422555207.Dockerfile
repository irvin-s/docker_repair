FROM strm/apache

LABEL maintainer "opsxcq@strm.sh"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    slapd ldap-utils \
    php5-ldap \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY phpldap /www

COPY ./ldap-conf /etc/ldap/slapd.d
RUN chown openldap -R /etc/ldap/slapd.d

COPY ./ldap-data /var/lib/ldap
RUN chown openldap -R /var/lib/ldap

COPY main.sh /
COPY config.php /www/config/config.php

ENTRYPOINT ["/main.sh"]

FROM debian:latest
MAINTAINER Cajus Pollmeier <pollmeier@gonicus.de>
ENV DEBIAN_FRONTEND=noninteractive
ENV LDAP_USER=openldap
ENV LDAP_GROUP=openldap

RUN apt-get update && \
    apt-get remove rpcbind && \
    apt-get -y install slapd && \
    rm -rf /etc/ldap /var/lib/ldap && \
    mkdir /etc/ldap /var/lib/ldap /var/lib/accesslog && \
    cp /usr/share/doc/slapd/examples/DB_CONFIG /var/lib/accesslog/DB_CONFIG && \
    chown -R openldap:openldap /var/lib/ldap /var/lib/accesslog && \
    apt-get clean

USER root
COPY start.sh /root

EXPOSE 389 636
ENTRYPOINT /root/start.sh

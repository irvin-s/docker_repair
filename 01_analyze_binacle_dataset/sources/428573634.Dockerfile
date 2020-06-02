# keystone
#
# VERSION               1.0

FROM ubuntu:latest
MAINTAINER Werner R. Mendizabal "werner.mendizabal@gmail.com"

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y slapd ldap-utils

RUN apt-get install -q -y vim ldapvi

ADD files /

RUN service slapd start;\
ldapadd -Y EXTERNAL -H ldapi:/// -f back.ldif;\
ldapadd -Y EXTERNAL -H ldapi:/// -f sssvlv_load.ldif;\
ldapadd -Y EXTERNAL -H ldapi:/// -f sssvlv_config.ldif;\
ldapadd -x -D cn=admin,dc=openstack,dc=org -w password -c -f front.ldif

EXPOSE 389

CMD slapd -h 'ldap:/// ldapi:///' -g openldap -u openldap -F /etc/ldap/slapd.d -d stats

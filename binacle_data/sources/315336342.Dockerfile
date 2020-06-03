FROM dinkel/openldap

LABEL maintainer="Scott Came (scottcame10@gmail.com)" \
  org.label-schema.description="Image with openldap server and some test users to support shiny demo" \
  org.label-schema.vcs-url="https://github.com/scottcame/shiny-microservice-demo/docker/shiny-openldap"

# docker run -d -p 1389:389 --name=shiny-openldap -e SLAPD_PASSWORD=password -e SLAPD_DOMAIN=ldap.localhost.localdomain shiny-openldap

RUN mkdir -p /etc/ldap.dist/prepopulate

COPY files/0*.ldif /etc/ldap.dist/prepopulate/

COPY files/9*.ldif /etc/ldap.dist/prepopulate/

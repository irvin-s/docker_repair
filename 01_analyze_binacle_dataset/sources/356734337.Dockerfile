
###################
# LTS
FROM ubuntu:16.04
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@cineca.it>"

###################
# Preparation
RUN apt-get update -qq && apt-get install -y \
        ## normal base
        wget git vim expect lsof sudo \
        ## fix adding irods to source list ?
        # lsb-release \
        # apt-transport-https \
        ## fix the ssl error for apt-key
        gnupg-curl \
        ## fix "The method driver /usr/lib/apt/methods/https could not be found"
        apt-transport-https \
        ## fix the plugin error at irods installation time
        libxml2 \
        ## GSI and Grid FTP dependencies
        globus-proxy-utils \
        globus-gsi-cert-utils-progs globus-simple-ca \
    # clean
    && apt-get clean autoclean && apt-get autoremove -y && \
    rm -rf /var/lib/cache /var/lib/log /tmp/*

###################
# Add repos, download and install
ENV URL https://packages.irods.org
RUN apt-key adv --fetch-keys $URL/irods-signing-key.asc \
    # && echo "deb $URL/apt/ $(lsb_release -sc) main" \
    && echo "deb $URL/apt/ trusty main" \
        > /etc/apt/sources.list.d/renci-irods.list

ENV IRODS_VERSION 4.2.0
ENV GSI_VERSION 2.0.0
RUN apt-get update && apt-get install -y \
        # iCAT
        irods-runtime=$IRODS_VERSION irods-icommands=$IRODS_VERSION \
        irods-server=$IRODS_VERSION \
        # iRODS Plugins (also GSI)
        irods-database-plugin-postgres=$IRODS_VERSION \
        irods-auth-plugin-gsi=$GSI_VERSION \
    # clean
    && apt-get clean autoclean && apt-get autoremove -y && \
    rm -rf /var/lib/cache /var/lib/log /tmp/*

# Note: USER and GROUP are added automatically by irods install scripts

###################
# OTHER OPERATIONS
ENV TERM xterm-256color

# certificates
ENV CERTDIR /opt/certificates
ENV CADIR $CERTDIR/simple_ca
RUN mkdir -p $CADIR
COPY add_irods_x509.sh /usr/local/bin/add-irods-X509
COPY switch_gsi_user.sh /usr/local/bin/switch-gsi
RUN echo "alias berods='HOME=/var/lib/irods su -p irods'" >> /root/.bash_aliases

# add certification authorities
ENV B2ACCESS_CAS /tmp/b2access_certificates
COPY b2access_certificates/b2access.ca.dev.pem $B2ACCESS_CAS/
COPY b2access_certificates/b2access.ca.dev.signing_policy $B2ACCESS_CAS/
COPY b2access_certificates/b2access.ca.prod.pem $B2ACCESS_CAS/
COPY b2access_certificates/b2access.ca.prod.signing_policy $B2ACCESS_CAS/

###################
# VOLUMES
VOLUME /etc
VOLUME /var/lib/irods
VOLUME /opt/certificates

###################
# ENTRYPOINT
# if you need to add future commands after irods installation:
# allow custom scripts to be executed at launch time
RUN mkdir /docker-entrypoint.d/
ENTRYPOINT ["docker-entrypoint"]
COPY ./expect_irods.sh /prepare_answers
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint

###################
# WORKDIR /tmp
EXPOSE 1247
CMD ["irods"]

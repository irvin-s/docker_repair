FROM rsoares/jon-agent

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael T. C. Soares <rafaelcba@gmail.com>

ENV EWS_VERSION=2.1
ENV HTTPD_HOME=$SOFTWARE_INSTALL_DIR/jboss-ews-$EWS_VERSION/httpd

RUN yum install -y apr-util mailcap openssl; yum clean all

RUN useradd -c "Apache" -u 48 -s /bin/sh -r apache

COPY software/*.zip /tmp/

RUN unzip '/tmp/jboss-ews-*.zip' -d $SOFTWARE_INSTALL_DIR/; \
	unzip '/tmp/jboss-eap-native-*.zip' -d $SOFTWARE_INSTALL_DIR/

# remove some unused module's conf
RUN rm $HTTPD_HOME/conf.d/proxy_ajp.conf; \
    rm $HTTPD_HOME/conf.d/auth_kerb.conf; \
    rm $HTTPD_HOME/conf.d/ssl.conf

# Copy the customized confs
COPY support/httpd.conf $HTTPD_HOME/conf/
COPY support/snmpd.conf $HTTPD_HOME/conf/
COPY support/mod_cluster.conf $HTTPD_HOME/conf.d/

# copy the jboss-eap native httpd modules
RUN cp $SOFTWARE_INSTALL_DIR/jboss-eap-*/modules/system/layers/base/native/lib64/httpd/modules/*.so \
	$HTTPD_HOME/modules/

WORKDIR $HTTPD_HOME

# run the EWS's post installation script
RUN . ./.postinstall; \
	chown -R apache: $HTTPD_HOME; \
	rm -r $SOFTWARE_INSTALL_DIR/jboss-eap-*

RUN rm -rf /tmp/jboss*; rm -rf /tmp/rhq*

COPY support/run.sh /

EXPOSE 80 6666

ENTRYPOINT ["/run.sh"]

FROM scottcame/shiny-tomcat8-proxied

LABEL maintainer="Scott Came (scottcame10@gmail.com)" \
  org.label-schema.description="Image with Shibboleth Identity Provider to support shiny demo" \
  org.label-schema.vcs-url="https://github.com/scottcame/shiny-microservice-demo/docker/shiny-idp"

WORKDIR /tmp

# note that images (or other resources) used by the Velocity templates in the webapp have to be installed in the war file, though
# the .vm resources themselves can be copied into /opt/shibboleth-idp/views/
# COPY files/*.png /tmp/

RUN curl -SsO http://shibboleth.net/downloads/identity-provider/3.3.2/shibboleth-identity-provider-3.3.2.zip && \
	unzip shibboleth-identity-provider-3.3.2.zip && cd shibboleth-identity-provider-3.3.2 && \
	echo "idp.entityID=https://idp.localhost.localdomain/idp/shibboleth" > props && \
	bin/install.sh -Didp.target.dir=/opt/shibboleth-idp -Didp.host.name=localhost -Didp.sealer.password=password \
		-Didp.keystore.password=password -Didp.src.dir=/tmp/shibboleth-identity-provider-3.3.2 -Didp.scope=localdomain \
		-Didp.noprompt=true -Didp.merge.properties=props && \
	cd /opt/shibboleth-idp/war && mkdir tmp && \
	mv idp.war tmp/ && cd tmp && \
	unzip idp.war && \
	curl -SsO https://repo1.maven.org/maven2/jstl/jstl/1.2/jstl-1.2.jar && \
	mv jstl-1.2.jar WEB-INF/lib && \
	# mv /tmp/*.png images/ && \
	cd .. && jar -cvfM idp.war -C tmp/ . && \
	rm -rf tmp && rm -rf /tmp/*

RUN cp -r /opt/shibboleth-idp/conf /tmp/

COPY files/saml-metadata.xml /opt/shibboleth-idp/metadata/saml-metadata.xml
COPY files/access-control.xml /opt/shibboleth-idp/conf/access-control.xml
COPY files/attribute-filter.xml /opt/shibboleth-idp/conf/attribute-filter.xml
COPY files/attribute-resolver.xml /opt/shibboleth-idp/conf/attribute-resolver.xml
COPY files/relying-party.xml /opt/shibboleth-idp/conf/relying-party.xml
COPY files/metadata-providers.xml /opt/shibboleth-idp/conf/metadata-providers.xml
COPY files/ldap.properties /opt/shibboleth-idp/conf/ldap.properties
COPY files/idp.properties /opt/shibboleth-idp/conf/idp.properties
COPY files/idp-signing-*.pem /opt/shibboleth-idp/credentials/
COPY files/login.vm /opt/shibboleth-idp/views/

RUN mkdir -p /opt/tomcat/conf/Catalina/localhost
RUN echo '<Context docBase="/opt/shibboleth-idp/war/idp.war" privileged="true" antiResourceLocking="false" swallowOutput="true" />' > /opt/tomcat/conf/Catalina/localhost/idp.xml

WORKDIR /opt/shibboleth-idp

FROM frolvlad/alpine-glibc:alpine-3.7

LABEL maintainer="Scott Came (scottcame10@gmail.com)" \
  org.label-schema.description="Image containing Apache with mod proxy and mod shib to support shiny demo" \
  org.label-schema.vcs-url="https://github.com/scottcame/shiny-microservice-demo/docker/shiny-apache-shib-sp"

RUN apk add --update bash apache2 apache2-ssl apache2-proxy apache2-dev apache2-ctl alpine-sdk openssl libressl-dev boost-dev curl-dev bzip2-dev zlib-dev

# This loosely follows the steps documented at https://wiki.shibboleth.net/confluence/display/SHIB2/NativeSPLinuxSourceBuild

WORKDIR /tmp

# Install log4shib

RUN wget http://shibboleth.net/downloads/log4shib/latest/log4shib-1.0.9.tar.gz && \
	tar -xvf log4shib-1.0.9.tar.gz && \
	cd log4shib-1.0.9 && \
	./configure --disable-static --disable-doxygen --prefix=/opt/shibboleth-sp CXXFLAGS="-std=c++11" && \
	make && \
	make install && \
	cd .. && rm -rf log4shib*

# Install XercesC

RUN wget http://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.1.2.tar.gz && \
	tar -xvf xerces-c-3.1.2.tar.gz && \
	cd xerces-c-3.1.2 && \
	./configure --prefix=/opt/shibboleth-sp --disable-netaccessor-libcurl && \
	make && \
	make install && \
	cd .. && rm -rf xerces-c*

# Install XML Security
# Note we have to apply a "patch" to get this to compile with GCC v6+
# See https://issues.apache.org/jira/browse/SANTUARIO-437

RUN wget http://www.apache.org/dist/santuario/c-library/xml-security-c-1.7.3.tar.gz && \
	tar -xvf xml-security-c-1.7.3.tar.gz && \
	cd xml-security-c-1.7.3 && \
	sed -i -e "648s/false/NULL/" xsec/tools/checksig/InteropResolver.cpp && \
	./configure --without-xalan --disable-static --prefix=/opt/shibboleth-sp --with-xerces=/opt/shibboleth-sp CXXFLAGS="-w" && \
	make && \
	make install && \
	cd .. && rm -rf xml-sec*

# Install OpenSAML XML Tooling

RUN wget http://shibboleth.net/downloads/c++-opensaml/latest/xmltooling-1.6.4.tar.gz && \
	tar -xvf xmltooling-1.6.4.tar.gz && \
	cd xmltooling-1.6.4 && \
	./configure --with-log4shib=/opt/shibboleth-sp --prefix=/opt/shibboleth-sp -C CXXFLAGS="-w" && \
	make && \
	make install && \
	cd .. && rm -rf xmltooling*

# Install OpenSAML

RUN wget http://shibboleth.net/downloads/c++-opensaml/latest/opensaml-2.6.1.tar.gz && \
	tar -xvf opensaml-2.6.1.tar.gz && \
	cd opensaml-2.6.1 && \
	./configure --with-log4shib=/opt/shibboleth-sp --prefix=/opt/shibboleth-sp -C CXXFLAGS="-w" && \
	make && \
	make install && \
	cd .. && rm -rf opensaml*

# Install Shib daemon

RUN wget http://shibboleth.net/downloads/service-provider/2.6.1/shibboleth-sp-2.6.1.tar.gz && \
	tar -xvf shibboleth-sp-2.6.1.tar.gz && \
	cd shibboleth-sp-2.6.1 && \
	./configure --with-log4shib=/opt/shibboleth-sp --prefix=/opt/shibboleth-sp --enable-apache-24 --with-apxs24=/usr/bin/apxs CXXFLAGS="-w" && \
	make && \
	make install && \
	cd .. && rm -rf shibboleth* && \
	apk del apache2-dev

# Copy config files over and do some editing

# Make startup script

RUN echo '#!/bin/bash' > /opt/shibboleth-sp/sbin/start-shib-and-apache && \
	echo "/opt/shibboleth-sp/sbin/shibd -f" >> /opt/shibboleth-sp/sbin/start-shib-and-apache && \
	echo "mkdir -p /run/apache2" >> /opt/shibboleth-sp/sbin/start-shib-and-apache && \
	echo "apachectl start -DFOREGROUND" >> /opt/shibboleth-sp/sbin/start-shib-and-apache && \
	chmod u+x /opt/shibboleth-sp/sbin/start-shib-and-apache

WORKDIR /opt/shibboleth-sp

COPY files/proxy.conf /etc/apache2/conf.d/
COPY files/shib.conf /etc/apache2/conf.d/
COPY files/*.xml /opt/shibboleth-sp/etc/shibboleth/
COPY files/*.pem /opt/shibboleth-sp/etc/shibboleth/

RUN sed -i s/SSLMutex/#SSLMutex/g /etc/apache2/conf.d/ssl.conf && \
	sed -i "s/#ServerName.*/ServerName localhost:80/g" /etc/apache2/httpd.conf && \
	sed -i "s/UseCanonicalName Off/UseCanonicalName On/g" /etc/apache2/httpd.conf

CMD ["/opt/shibboleth-sp/sbin/start-shib-and-apache"]

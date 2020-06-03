FROM debian:jessie

ENV CLOUDCONFIG_INSTALL_DIR     /opt/cloudconfig
ENV	DEBIAN_FRONTEND             noninteractive
ENV PATH                        ${CLOUDCONFIG_INSTALL_DIR}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#Core OS image from where we extract the coreos-cloudinit tool (used to verify cloudinit files)
ENV	COREOS_CHANNEL_ID           stable
ENV	COREOS_VERSION_ID           717.1.0
ENV	COREOS_IMAGE_URL            http://${COREOS_CHANNEL_ID}.release.core-os.net/amd64-usr/${COREOS_VERSION_ID}/coreos_production_pxe_image.cpio.gz

# install required packges
RUN	apt-get update -qq && \
	apt-get install -y cpio squashfs-tools curl apache2 php5 php5-curl bzip2 openssl git && \
	apt-get clean autoclean && \
	apt-get autoremove --yes && \
	rm -rf /var/lib/{apt,dpkg,cache,log}/

# extract coreos-cloudinit from CoreOS Image file
WORKDIR	/tmp
RUN	curl -L --silent ${COREOS_IMAGE_URL} | zcat | cpio -iv && \
	unsquashfs usr.squashfs && \
	cp squashfs-root/bin/coreos-cloudinit /usr/local/bin && \
    cp squashfs-root/bin/fleetctl /usr/local/bin && \
    cp squashfs-root/bin/etcdctl /usr/local/bin && \
    rm -rf /tmp/*

# configure apache & prepare install dir
ADD	conf/apache2/cloudconfig.conf /etc/apache2/sites-available/cloudconfig.conf
RUN	a2dissite 000-default && \
	a2ensite cloudconfig && \
	a2enmod php5 && \
	a2enmod rewrite && \
	mkdir ${CLOUDCONFIG_INSTALL_DIR}


ADD	composer.json composer.lock ${CLOUDCONFIG_INSTALL_DIR}/
ADD	bin/ ${CLOUDCONFIG_INSTALL_DIR}/bin/
ADD	conf/ ${CLOUDCONFIG_INSTALL_DIR}/conf/
ADD	features/ ${CLOUDCONFIG_INSTALL_DIR}/features/
ADD	www/ ${CLOUDCONFIG_INSTALL_DIR}/www/



WORKDIR     ${CLOUDCONFIG_INSTALL_DIR}
RUN         curl -sS https://getcomposer.org/installer | php && \
            php composer.phar install && \
            rm composer.*


WORKDIR     /root

COPY docker-entrypoint.sh /usr/local/sbin/docker-entrypoint.sh

ENTRYPOINT      ["/usr/local/sbin/docker-entrypoint.sh"]

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

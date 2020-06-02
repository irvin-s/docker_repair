FROM lsiobase/ubuntu:xenial

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# environment variables
ARG DEBIAN_FRONTEND="noninteractive"
ENV MYSQL_DIR="/data"
ENV DATADIR=$MYSQL_DIR/database

# packages as variables
ARG BUILD_DEPENDENCIES="\
	cmake \
	dh-autoreconf \
	dpatch \
	g++ \
	gcc \
	git \
	libavcodec-dev \
	libavdevice-dev \
	libavfilter-dev \
	libavformat-dev \
	libavresample-dev \
	libavutil-dev \
	libcurl4-openssl-dev \
	libjpeg-turbo8-dev \
	libmp4v2-dev \
	libmysqlclient-dev \
	libnetpbm10-dev \
	libpcre3-dev \
	libpolkit-gobject-1-dev \
	libpostproc-dev \
	libswscale-dev \
	libtheora-dev \
	libtool \
	libv4l-dev \
	libvlccore-dev \
	libvlc-dev \
	libvorbis-dev \
	libvpx-dev \
	libx264-dev \
	php-dev \
	php-pear \
	yasm"

ARG RUNTIME_DEPENDENCIES="\
	apache2 \
	ffmpeg \
	libapache2-mod-php \
	libarchive-zip-perl \
	libav-tools \
	libbz2-dev \
	libclass-std-fast-perl \
	libcurl3 \
	libdata-dump-perl \
	libdata-uuid-perl \
	libdate-manip-perl \
	libdbd-mysql-perl \
	libdbi-perl \
	libdevice-serialport-perl \
	libio-socket-multicast-perl \
	libjpeg-turbo8 \
	libmime-lite-perl \
	libmime-perl \
	libmp4v2-2 \
	libpcre3 \
	libsoap-wsdl-perl \
	libssl-dev \
	libsys-cpu-perl \
	libsys-meminfo-perl \
	libsys-mmap-perl \
	libvlc5 \
	libvlccore8 \
	libwww-perl \
	mariadb-client \
	mariadb-server \
	net-tools \
	php \
	php-cli \
	php-mysql \
	unzip \
	vlc-data \
	zip"

RUN \
 echo "**** add repositories ****" && \
 apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
 echo "deb [arch=amd64,i386] http://mirrors.coreix.net/mariadb/repo/10.1/ubuntu xenial main" >> \
	/etc/apt/sources.list.d/mariadb.list && \
 echo "deb-src http://mirrors.coreix.net/mariadb/repo/10.1/ubuntu xenial main" >> \
	/etc/apt/sources.list.d/mariadb.list && \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
	--no-install-recommends \
	$BUILD_DEPENDENCIES \
	$RUNTIME_DEPENDENCIES && \
 echo "**** install php_apcu and php_apcu-bc ****" && \
 pecl install apcu && \
 pecl install apcu_bc-beta && \
 echo "extension=apc.so" >> /etc/php/7.0/mods-available/z_apc.ini && \
 echo "extension=apcu.so" >> /etc/php/7.0/mods-available/apcu.ini && \
 ln -sf \
	/etc/php/7.0/mods-available/apcu.ini \
	/etc/php/7.0/apache2/conf.d/20-apcu.ini && \
 ln -sf \
	/etc/php/7.0/mods-available/apcu.ini \
	/etc/php/7.0/cli/conf.d/20-apcu.ini && \
 ln -sf \
	/etc/php/7.0/mods-available/z_apc.ini \
	/etc/php/7.0/apache2/conf.d/40-apc.ini && \
 ln -sf \
	/etc/php/7.0/mods-available/z_apc.ini \
	/etc/php/7.0/cli/conf.d/40-apc.ini && \
 echo "**** build zoneminder ****" && \
 git clone https://github.com/ZoneMinder/ZoneMinder /tmp/zoneminder && \
 cd /tmp/zoneminder && \
 git submodule update --init --recursive && \
 cmake \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DZM_CGIDIR=/usr/share/webapps/zoneminder/cgi-bin \
	-DZM_CONFIG_DIR=/etc/zm \
	-DZM_CONFIG_SUBDIR=/etc/zm/conf.d \
	-DZM_DIR_EVENTS=/data/zoneminder/events \
	-DZM_DIR_IMAGES=/data/zoneminder/images \
	-DZM_DIR_SOUNDS=/data/zoneminder/sounds \
	-DZM_LOGDIR=/config/log/zoneminder \
	-DZM_PATH_ARP=/usr/sbin/arp \
	-DZM_RUNDIR=/var/run/zoneminder \
	-DZM_SOCKDIR=/var/run/zoneminder \
	-DZM_WEBDIR=/usr/share/webapps/zoneminder/htdocs \
	-DZM_WEB_GROUP=abc \
	-DZM_WEB_USER=abc \
	. && \
 make && \
 make install && \
 echo "**** configure zoneminder exports folder and add abc to video group ****" && \
 sed -i \
	-e "s#\(ZM_DIR_EXPORTS.*=\).*#\1/data/zoneminder/exports#g" \
	/etc/zm/conf.d/01-system-paths.conf && \
 adduser abc video && \
 echo "**** configure apache ****" && \
 cp misc/apache.conf /defaults/default.conf && \
 a2enmod cgi rewrite && \
 sed -i \
	-e "s/\(.*APACHE_RUN_USER=\).*/\1abc/g" \
	-e "s/\(.*APACHE_RUN_GROUP=\).*/\1abc/g" \
		/etc/apache2/envvars && \
 echo "**** configure my.cnf and mysqld_safe ****" && \
 sed \
	-i -e 's/^#sql_mode/sql_mode/g' \
	-i -e 's/NO_ENGINE_SUBSTITUTION.*/NO_ENGINE_SUBSTITUTION/g' \
	-i -e 's/key_buffer\b/key_buffer_size/g' \
	-i -e 's#/var/log/mysql#/config/log/mysql#g' \
	-i -e 's/\(max_allowed_packet.*=\).*/\1 128M/g' \
	-i -e 's/\(user.*=\).*/\1 abc/g' \
	-i -e 's/\(wait_timeout.*=\).*/\1 1200/g' \
	-i -e "s#\(datadir.*=\).*#\1 $DATADIR#g" \
	-ri -e 's/^(bind-address|skip-networking)/;\1/' \
		/etc/mysql/my.cnf && \
 sed -i \
	"s/user='mysql'/user='abc'/g" \
		/usr/bin/mysqld_safe && \
 echo "**** uninstall build packages and reinstall runtime packages ****" && \
 apt-get purge -y --auto-remove \
	$BUILD_DEPENDENCIES && \
 apt-get install -y \
	--no-install-recommends \
	$RUNTIME_DEPENDENCIES && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/lib/mysql \
	/var/tmp/* && \
 mkdir -p \
	/var/lib/mysql

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config /data

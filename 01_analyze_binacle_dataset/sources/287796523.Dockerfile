FROM gjchen/wsproxy

ENV	BUILD_DEPS="make build-essential git" \
	QKMJ_SERVER="0.0.0.0 7001" \
	MJQPS_DAEMON_PORT=7001 \
	WSPROXY_ADDR="0.0.0.0:23" \
	TERMINFO="/lib/terminfo" \
	TERM=vt220

RUN	apt-get update && apt-get dist-upgrade -y && apt-get install -y ${BUILD_DEPS} libncurses5-dev inetutils-inetd inetutils-telnetd libc6-i386 \
	&& \
	cd /opt && git clone https://github.com/gjchentw/qkmj.git && \
	cd /opt/qkmj/qkmjclient && make && \
	cd /opt/qkmj/qkmjserver && make && \
	mkdir -p /var/qkrecord && chown -R games:games /var/qkrecord \
	&& \
	apt-get purge -y ${BUILD_DEPS} && apt-get autoremove -y && apt-get autoclean -y

	
EXPOSE	80
VOLUME	[ "/var/qkrecord" ]
CMD	echo "telnet\tstream\ttcp\tnowait\tgames:games\t/usr/sbin/tcpd\t/usr/sbin/telnetd -E '/opt/qkmj/qkmjclient/qkmj ${QKMJ_SERVER}'"> /etc/inetd.conf && inetutils-inetd && nginx -g 'daemon on;' && /opt/qkmj/qkmjserver/mjgps ${MJQPS_DAEMON_PORT}

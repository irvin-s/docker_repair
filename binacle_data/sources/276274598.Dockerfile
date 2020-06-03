FROM openwrt/build/base

ADD resources /root/resources

RUN mkdir -p /root/certs/keys \
	&& mv /root/resources/keys/* /root/certs/keys/ \
	&& mv /root/certs/keys/vpn-server-cert.pem /etc/ipsec.d/certs/ \
	&& mv /root/certs/keys/vpn-server-key.pem /etc/ipsec.d/private/ \
	&& mv /root/resources/strongswan/*  /etc/strongswan.d/ \
	&& mv /root/resources/ipsec/* /etc/ \
	&& mv /root/resources/config/firewall /etc/config/ \
	&& mv /root/resources/config/network /etc/config/ \
	&& mv /root/resources/config/uhttpd /etc/config/ \
	&& mv /root/resources/config/firewall.user /etc/ \
	&& mv /root/resources/bin/* /etc/init.d/ \
	&& ln -s /etc/init.d/getips /etc/rc.d/S20getips \
	&& ln -s /etc/init.d/getips /etc/rc.d/K90getips \
	&& ln -s /etc/init.d/setroutes /etc/rc.d/S99setroutes \
	&& ln -s /etc/init.d/setroutes /etc/rc.d/K99ysetroutes \
	&& rm -rf /root/resources/

USER root

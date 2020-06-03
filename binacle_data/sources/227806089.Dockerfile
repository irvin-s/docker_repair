FROM debian:buster-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		wget \
# add "apt-transport-https" for images whose "/etc/apt/sources.list" uses "https"
		apt-transport-https \
# redhat-based images!
		rpm \
		yum-utils \
	; \
	rm -rf /var/lib/apt/lists/*

# Alpine-based images need "apk" for data extraction
RUN set -eux; \
# https://pkgs.alpinelinux.org/package/v3.9/main/x86_64/apk-tools-static
	apkStaticDist='v3.9'; \
	apkStaticVersion='2.10.3-r1'; \
# TODO convert "dpkg --print-architecture" to Alpine architecture for downloading the correct architecture binary
	apkStaticArch='x86_64'; \
	apkStaticUrl="http://dl-cdn.alpinelinux.org/alpine/$apkStaticDist/main/$apkStaticArch/apk-tools-static-$apkStaticVersion.apk"; \
	wget -O /tmp/apk-tools-static.apk "$apkStaticUrl"; \
	tar -xzvf /tmp/apk-tools-static.apk -C /usr/local/ --wildcards '*bin/apk.static'; \
	mv /usr/local/*bin/apk.static /usr/local/bin/apk; \
	rm /tmp/apk-tools-static.apk; \
	apk --version

COPY .local-scripts/*.sh /usr/local/bin/

CMD ["gather.sh"]

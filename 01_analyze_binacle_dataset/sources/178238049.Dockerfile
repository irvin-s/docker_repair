FROM frolvlad/alpine-glibc:latest
MAINTAINER Odd Eivind Ebbesen <odd@oddware.net>

RUN apk add --update --no-cache \
		ca-certificates \
		openssl \
		python3 \
		tini \
		wget \
		&& \
		addgroup -g 1000 dropbox \
		&& \
		adduser -u 1000 -G dropbox -D dropbox \
		&& \
		wget -nv -O /tmp/dropbox.tgz https://www.dropbox.com/download?plat=lnx.x86_64 \
		&& \
		tar -xzf /tmp/dropbox.tgz -C /usr/local \
		&& \
		mv /usr/local/.dropbox-dist /usr/local/dropbox-dist \
		&& \
		ln -s /usr/local/dropbox-dist/dropboxd /usr/local/bin/ \
		&& \
		rm -f /tmp/dropbox.tgz \
		&& \
		wget -nv -O /usr/local/bin/dropbox-cli https://linux.dropbox.com/packages/dropbox.py \
		&& \
		chmod 755 /usr/local/bin/dropbox-cli \
		&& \
		apk del wget \
		&& \
		rm -rf /var/cache/apk/*

VOLUME ["/home/dropbox/Dropbox"]
EXPOSE 17500
USER dropbox
# Try to prevent automatic updates that kills the container
# See: https://wiki.archlinux.org/index.php/dropbox
RUN install -dm0 ~/.dropbox-dist
ENTRYPOINT ["tini", "-g", "--"]
CMD ["dropboxd"]

FROM httpd-php

MAINTAINER fatherlinux <scott.mccarty@gmail.com>

USER 1001

VOLUME /var/www/html

ENV MEDIAWIKI_VERSION 1.28

# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
COPY ./mediawiki.keys /mediawiki.keys
RUN curl -o /usr/src/mediawiki.tar.gz -SL https://releases.wikimedia.org/mediawiki/${MEDIAWIKI_VERSION}/mediawiki-${MEDIAWIKI_VERSION}.0.tar.gz \
	&& curl -o /usr/src/mediawiki.tar.gz.sig -SL https://releases.wikimedia.org/mediawiki/${MEDIAWIKI_VERSION}/mediawiki-${MEDIAWIKI_VERSION}.0.tar.gz.sig \
	&& gpg --import /mediawiki.keys \
	&& gpg --verify /usr/src/mediawiki.tar.gz.sig /usr/src/mediawiki.tar.gz \
	&& tar -xzf /usr/src/mediawiki.tar.gz -C /usr/src/ \
	&& rm /usr/src/mediawiki.tar.gz /usr/src/mediawiki.tar.gz.sig

COPY ./docker-entrypoint.sh /entrypoint.sh

# grr, ENTRYPOINT resets CMD now
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/cmd.sh"]

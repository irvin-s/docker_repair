FROM wordpress:4-php7.1-fpm-alpine
MAINTAINER Azure App Service Container Images <appsvc-images@microsoft.com>
# ========
# ENV vars
# ========
# redis
ENV PHPREDIS_VERSION 3.1.2
ENV WPFPM_FLAG WPFPM_
ENV PAGER more
# ssh
ENV SSH_PASSWD "root:Docker!"
#
# --------
# ~. tools
# --------
RUN set -ex \
  && apk update \
  && apk add --update openssl git net-tools tcpdump tcptraceroute vim curl wget bash\
	&& cd /usr/bin \
	&& wget http://www.vdberg.org/~richard/tcpping \
	&& chmod 777 tcpping 
# ========
# install the PHP extensions we need and xdebug
# ======== 
RUN docker-php-source extract \
  && curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
  && tar xfz /tmp/redis.tar.gz \
  && rm -r /tmp/redis.tar.gz \
  && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
  && docker-php-ext-install redis \
  && docker-php-source delete \
  && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp \
  && apk add --update $PHPIZE_DEPS \
  && pecl install xdebug-beta \
# ------
# ssh
# ------
  && apk add --update openssh-server \
	&& echo "$SSH_PASSWD" | chpasswd 
COPY sshd_config /etc/ssh/
#---------------
# openrc service
#---------------
RUN set -ex \
  && apk update && apk add openrc \
# can't do cgroups
  && sed -i 's/"cgroup_add_service/" # cgroup_add_service/g' /lib/rc/sh/openrc-run.sh \      
# ----------
# ~. upgrade/clean up
# ----------
	&& apk update \
	&& apk upgrade \
	&& rm -rf /var/cache/apk/*   
# =====
# final
# =====    
ADD uploads.ini /usr/local/etc/php/conf.d/
ADD my.bashrc /root/.bashrc
COPY php.ini /usr/local/etc/php/php.ini
COPY xdebug.ini /usr/local/etc/php/conf.d/
COPY BaltimoreCyberTrustRoot.crt.pem /usr/src

#EXPOSE 2222
COPY docker-entrypoint.sh /usr/local/bin
COPY entrypoint.sh /usr/local/bin/
COPY BaltimoreCyberTrustRoot.crt.pem /usr/src/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["php-fpm"]

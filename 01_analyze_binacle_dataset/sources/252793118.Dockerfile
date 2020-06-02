FROM dankempster/composer:base  
  
MAINTAINER dev@dankempster.co.uk  
  
ENV XDEBUG_VERSION 2.5.0  
ENV XDEBUG_SHA1 0d31602a6ee2ba6d2e18a6db79bdb9a2a706bcd9  
  
RUN set -x \  
&& curl -o xdebug.tgz "https://xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz" \  
&& echo "$XDEBUG_SHA1 xdebug.tgz" | sha1sum -c - \  
&& mkdir -p /usr/src/xdebug \  
&& tar -xf xdebug.tgz -C /usr/src/xdebug --strip-components=1 \  
&& rm xdebug.* \  
&& cd /usr/src/xdebug \  
&& phpize \  
&& ./configure \  
&& make -j"$(nproc)" \  
&& make install \  
&& make clean \  
&& docker-php-ext-enable xdebug \  
&& cd \- \  
&& rm -fr /usr/src/xdebug  
  
# Set PHP config  
COPY config/*.ini /usr/local/etc/php/conf.d/


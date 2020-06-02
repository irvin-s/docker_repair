FROM phusion/baseimage  
  
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
# Build packages first  
RUN export DEBIAN_FRONTEND=noninteractive && \  
echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup && \  
add-apt-repository -y ppa:ondrej/php &&\  
apt-get update && \  
apt-get --no-install-recommends -y --force-yes install \  
php5.6 \  
php5.6-mysql \  
php5.6-imagick \  
php5.6-mcrypt \  
php5.6-curl \  
php5.6-cli \  
php5.6-memcache \  
php5.6-intl \  
php5.6-gd \  
php5.6-redis \  
php5.6-xsl \  
php5.6-intl \  
php5.6-zip \  
php5.6-mbstring \  
php5.6-soap \  
curl \  
# Install PHP 7.0  
php7.0 \  
php7.0-cli \  
php7.0-common \  
php7.0-gd \  
php7.0-mysql \  
php7.0-curl \  
php7.0-int \  
php7.0-mcrypt \  
php7.0-tidy \  
php7.0-imap \  
php7.0-xsl \  
php7.0-dev \  
php7.0-mbstring \  
php7.0-bcmath \  
php7.0-xml \  
php7.0-zip \  
php7.0-soap \  
# Install PHP 7.1  
php7.1 \  
php7.1-cli \  
php7.1-common \  
php7.1-gd \  
php7.1-mysql \  
php7.1-curl \  
php7.1-int \  
php7.1-mcrypt \  
php7.1-tidy \  
php7.1-imap \  
php7.1-xsl \  
php7.1-dev \  
php7.1-mbstring \  
php7.1-bcmath \  
php7.1-xml \  
php7.1-zip \  
php7.1-soap  
  
# Cleanup  
RUN apt-get clean && \  
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup && \  
find /var/lib/apt/lists -mindepth 1 -delete -print && \  
find /tmp /var/tmp -mindepth 2 -delete && \  
apt-get purge -y --auto-remove  
  
# Copy php config  
COPY php.ini /etc/php/5.6/cli/php.ini  
COPY php.ini /etc/php/7.0/cli/php.ini  
COPY php.ini /etc/php/7.1/cli/php.ini  
  
COPY init /etc/my_init.d  
  
WORKDIR /var/www/htdocs


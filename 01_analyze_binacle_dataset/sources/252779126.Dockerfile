# Use the multi-stage feature to import Composer securely  
FROM composer:1.6  
# Use PHP as primary language  
FROM php:7.2  
# Update, upgrade and install some dependencies  
RUN apt-get update \  
&& apt-get upgrade -y \  
&& apt-get install -y \  
git \  
gnupg \  
libpng-dev \  
libsqlite3-dev \  
unzip \  
&& apt-get autoremove -y  
  
# Install additional required PHP extensions  
RUN docker-php-ext-install \  
pdo_sqlite  
  
# Install and enable xdebug  
RUN pecl install xdebug \  
&& docker-php-ext-enable xdebug  
  
# Add Node 8 LTS  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -- \  
&& apt-get install -y nodejs \  
&& apt-get autoremove -y  
  
# Update NPM to the latest version  
RUN npm install -g npm@latest \  
&& rm -r ~/.npm  
  
# Add Composer  
COPY \--from=composer /usr/bin/composer /usr/bin/composer  
  
# Suppress the do-not-run-as-root warning from composer  
ENV COMPOSER_ALLOW_SUPERUSER 1  
# Show the versions of PHP, Node, Composer and NPM  
CMD \  
echo "Node $(node -v)"; \  
echo "NPM $(npm -v)"; \  
php -v; \  
composer --version;  


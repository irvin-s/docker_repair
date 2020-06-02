FROM php:7.1-fpm

ARG DOCKER_USER="devops"
ARG GIT_USER_NAME="John Doe"
ARG GIT_USER_EMAIL="johndoe@example.com"


# Install packages
RUN apt-get update \
    && apt-get install -y \
        libicu-dev \
        zlib1g-dev \
        git \
        sudo \
        wget \
        nano \
    && docker-php-ext-install \
        zip \
        intl \
        json \
        mbstring \
        mysqli \
        pdo_mysql \
    && php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer


# Install xdebug extention
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug


# Install PhpMetrics
RUN wget -O /phpmetrics.phar http://github.com/phpmetrics/PhpMetrics/raw/master/build/phpmetrics.phar
RUN chmod +x /phpmetrics.phar
RUN mv /phpmetrics.phar /usr/local/bin/phpmetrics


# Add user DOCKER_USER defined in .env & give sudo privilege
RUN adduser --disabled-password --gecos '' ${DOCKER_USER}
RUN adduser ${DOCKER_USER} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


# Override default bash config
ADD .bashrc /home/${DOCKER_USER}/.bashrc
RUN chown ${DOCKER_USER}:${DOCKER_USER} /home/${DOCKER_USER}/.bashrc


# Install Php cs-fixer
RUN wget -O /php-cs-fixer-v2.phar http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar
RUN chmod +x /php-cs-fixer-v2.phar
RUN mv /php-cs-fixer-v2.phar /usr/local/bin/php-cs-fixer


# Configure git
RUN su ${DOCKER_USER} -c "git config --global user.name ${GIT_USER_NAME}"
RUN su ${DOCKER_USER} -c "git config --global user.email ${GIT_USER_EMAIL}"
RUN su ${DOCKER_USER} -c "git config --global core.editor nano"


# Install TIG (cli git interface)
RUN apt-get install tig


# Install NodeJs
RUN curl -o /tmp/setup_node.sh https://deb.nodesource.com/setup_6.x
RUN chmod +x /tmp/setup_node.sh
RUN /tmp/setup_node.sh
RUN apt-get update \
    && apt-get install -y \
    nodejs \
    build-essential


# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update \
    && apt-get install -y \
    yarn


# Add Provisionning Scripts
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

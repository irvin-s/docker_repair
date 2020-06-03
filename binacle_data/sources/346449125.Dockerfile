FROM php:5-alpine

MAINTAINER account@itscaro.me

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Alternatively use ADD https:// (which will not be cached by Docker builder)
RUN echo "Pulling watchdog binary from Github." \
    && curl -sSL https://github.com/alexellis/faas/releases/download/0.6.5/fwatchdog > /usr/bin/fwatchdog \
    && chmod +x /usr/bin/fwatchdog

RUN addgroup -S app && adduser -S -g app app

# Core
WORKDIR /root/

COPY index.php php-extension.sh composer.*    ./

RUN chmod u+x ./php-extension.sh && ./php-extension.sh
#USER app
RUN composer install --no-dev
#USER root

# Function
COPY function   function

WORKDIR /root/function/

RUN [[ -f php-extension.sh ]] && sh ./php-extension.sh || \
    echo "php-extension.sh does not exist, skip installing PHP extensions"
#USER app
RUN [[ -f composer.lock || -f composer.json ]] && composer install --no-dev || \
    echo "composer.lock does not exists, skip installing composer dependencies"
#USER root

WORKDIR /root/

ENV fprocess "php index.php"

HEALTHCHECK --interval=1s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]

FROM composer/composer

WORKDIR /app

# Install Zenaton
RUN curl https://install.zenaton.com | sh

# Install dependencies
ADD composer.json composer.lock ./
RUN composer install

ENTRYPOINT ["./start_zenaton"]

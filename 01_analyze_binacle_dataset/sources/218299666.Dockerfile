FROM ubuntu

RUN apt-get update && \
    apt-get install -y git wget php7.0-cli php7.0-mbstring php7.0-dom php7.0-sqlite3 php7.0-intl && \
    wget -O - https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

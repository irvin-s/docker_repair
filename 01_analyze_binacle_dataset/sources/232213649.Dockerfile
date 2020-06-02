FROM wordpress:5

ENV WP_PATH="/var/www/html"

RUN apt-get update && \
    apt-get install -y \
    git \
    curl \
    wget \
    vim \
    mysql-client && \
    docker-php-ext-install mysqli && \
    apt-get clean

RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail && \
    cp /root/go/bin/mhsendmail /usr/bin/mhsendmail

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    php wp-cli.phar --info && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

ADD . $WP_PATH
WORKDIR $WP_PATH
EXPOSE 80

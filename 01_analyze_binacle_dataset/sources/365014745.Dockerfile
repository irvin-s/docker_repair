FROM likol1227/php7

RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer

RUN wget https://github.com/puli/cli/releases/download/1.0.0-beta9/puli.phar && chmod +x puli.phar && mv puli.phar /usr/local/bin/puli

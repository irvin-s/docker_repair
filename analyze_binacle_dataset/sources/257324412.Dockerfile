FROM douglaszuqueto/php

# Repository/Image Maintainer
MAINTAINER Douglas Zuqueto <douglas.zuqueto@gmail.com>

# Reset user to root to allow software install
USER root

# Installs Caddy
RUN curl https://getcaddy.com | bash -s realip

# Copy Caddyfile and entry script
COPY Caddyfile /home/php-user/Caddyfile
COPY start.sh  /home/php-user/start.sh

RUN chmod +x /home/php-user/start.sh && \
    chown -R php-user:php-user /home/php-user && \
    setcap CAP_NET_BIND_SERVICE=+eip /usr/local/bin/caddy

# Define the running user
USER php-user

# Application directory
WORKDIR "/var/www/app"

# Expose webserver port
EXPOSE 443

# Starts a single shell script that puts php-fpm as a daemon and caddy on foreground
CMD ["/home/php-user/start.sh"]

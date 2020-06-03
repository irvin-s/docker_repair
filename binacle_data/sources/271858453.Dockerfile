FROM php:7.2-zts-alpine

# build arguments
ARG BUILD_UID=1000
ARG BUILD_WITH_OPENSSH=0
ARG BUILD_WITH_XDEBUG=0
ARG XDEBUG_REMOTE_CONNECT_BACK=0
ARG XDEBUG_REMOTE_HOST=localhost

# install packages
RUN apk update && apk add --no-cache \
    bash sudo supervisor \
    g++ make autoconf \
    libxml2-dev icu-dev curl-dev pcre-dev tzdata

# install php extensions
RUN docker-php-ext-install curl

# install xdebug
RUN [[ "$BUILD_WITH_XDEBUG" != "1" ]] || ( \
    curl -sSL https://github.com/xdebug/xdebug/archive/bb90b66.zip -o /tmp/xdebug.zip \
    && unzip /tmp/xdebug.zip -d /tmp \
    && cd /tmp/xdebug-* \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && rm -rf /tmp/xdebug* \
)

# enable xdebug
RUN [[ "$BUILD_WITH_XDEBUG" != "1" ]] || ( \
    docker-php-ext-enable xdebug \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=${XDEBUG_REMOTE_CONNECT_BACK}" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_host=${XDEBUG_REMOTE_HOST}" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
)

# add composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# make the bash prompt pretty and add common aliases
RUN mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh \
    && echo -e "alias l='ls -CF'\n\
alias la='ls -A'\n\
alias ll='ls -alF'\n\
alias ls='ls --color=auto'" >> /etc/profile.d/aliases.sh

# add the unprivileged "app" user and allow passwordless sudo
RUN adduser -D -s /bin/bash -u $BUILD_UID alpine \
    && addgroup alpine wheel \
    && echo "alpine:" | chpasswd \
    && echo -e "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/docker

# configure supervisord to run in the foreground
RUN sed -E -i "s/^(; ?)?nodaemon=false/nodaemon=true/" /etc/supervisord.conf \
    && sed -E -i "s#^(; ?)?pidfile=.*#pidfile=/var/run/supervisord.pid#" /etc/supervisord.conf

# add the app to supervisord
RUN echo -e "\n\
[program:app]\n\
autorestart=true\n\
directory=/opt/project\n\
command=/usr/local/bin/php laravel/artisan serve --host=0.0.0.0\n\
stdout_logfile=/dev/stdout\n\
stdout_logfile_maxbytes=0\n\
stderr_logfile=/dev/stderr\n\
stderr_logfile_maxbytes=0\n\
user=alpine\n\
" >> /etc/supervisord.conf

# configure openssh, while this isn't a usual use-case for docker, connecting via SSH significantly speeds
# up debugging in PhpStorm as its docker-compose support does not support reusing a container which has
# already been brought up
RUN [[ "$BUILD_WITH_OPENSSH" != "1" ]] || ( \
    apk add --no-cache openssh \
    && ssh-keygen -A \
    && echo -e "\n[program:sshd]\ncommand=/usr/sbin/sshd -D\n" >> /etc/supervisord.conf \
)

# create the .ssh folder in the home directory and write the public key if specified to authorized_keys
RUN [[ "$BUILD_WITH_OPENSSH" != "1" ]] || ( \
    mkdir /home/alpine/.ssh \
    && chmod 700 /home/alpine/.ssh \
    && touch /tmp/authorized_keys \
    && chmod 600 /tmp/authorized_keys \
    && ( [ "$APP_USER_PUBLIC_KEY" == "" ] || echo $APP_USER_PUBLIC_KEY > /tmp/authorized_keys \
            && mv /tmp/authorized_keys /home/alpine/.ssh/ \
       ) \
    && chown -R alpine:alpine /home/alpine/.ssh/ \
)

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

USER alpine

WORKDIR /home/alpine

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

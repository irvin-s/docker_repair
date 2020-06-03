#
# PHP FPM Dev Dockerfile
# 在ibbd/php-fpm的基础上安装开发环境
#
# https://github.com/ibbd/dockerfile-fpm-php-fpm/php-dev
#
# sudo docker build -t ibbd/php-fpm-dev ./
#

# Pull base image.
FROM ibbd/php-fpm-ext

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装公共测试工具及开发工具
# 使用pecl install xdebug, 会有warning：Xdebug MUST be loaded as a Zend extension in Unknown on line 0
# xdebug 必须使用 zend_extension_ts 或者 zend_extension 来标明它是zend的扩展
# extension意为基于php引擎的扩展，zend_extension意为基于zend引擎的扩展
# xdebug does not have REST dependency information
# install phpDocumentor  (需要 Graphviz)
# @see http://www.phpdoc.org/
# @see http://www.phpdoc.org/docs/latest/index.html
# phptrace安装之后会导致php用不了
#&& pecl install trace \
#&& echo "extension=trace.so" > /usr/local/etc/php/conf.d/trace.ini \
COPY phpunit.phar /usr/local/bin/phpunit
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        man \
        git-core \
        vim-tiny \
        Graphviz \
        tcpdump \
        strace \
    && echo "set fileencodings=utf-8" >> /etc/vim/vimrc \
    && echo "set fileencoding=utf-8" >> /etc/vim/vimrc \
    && echo "set encoding=utf-8" >> /etc/vim/vimrc \
    && git config --global push.default simple \
    && pear install doc.php.net/pman \
    && pear upgrade pear \
    && pear channel-discover pear.phpdoc.org \
    && pear install phpdoc/phpDocumentor \
    && pecl install --force --alldeps xdebug \
    && echo "zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini \
    && pecl install xhprof-0.9.4 \
    && echo "extension=xhprof.so" > /usr/local/etc/php/conf.d/xhprof.ini \
    && chmod +x /usr/local/bin/phpunit \
    && pecl clear-cache \
    && apt-get autoremove \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*


# 终端设置
# 执行php-fpm时，默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
#ENV TERM xterm

WORKDIR /var/www


FROM registry.cn-hangzhou.aliyuncs.com/dailybird/docker-php7.1-fpm:0.0.1

MAINTAINER dailybird <dailybirdo@gmail.com>

# 具体更改可参见 https://github.com/dailybird/docker-php7.1-dockerfile/blob/master/Dockerfile

# 将对应的配置文件拷贝到容器中的 PHP 配置目录中，以覆盖原有的 PHP 配置
COPY ./config/php.ini /usr/local/etc/php/conf.d/
COPY ./config/opcache-recommended.ini /usr/local/etc/php/conf.d/

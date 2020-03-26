#BUILD_PUSH=hub,quay
FROM php:5.6-cli

RUN apt-get update && apt-get install -y libc6-dev \
    && docker-php-ext-install pdo_mysql \
    && apt-get -y remove --purge libc6-dev \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'date.timezone = "UTC"' > /usr/local/etc/php/conf.d/timezone.ini

#
#RUN apt-get update && apt-get install -y libcurl4-openssl-dev \
#    && apt-get -y autoremove \
#    && rm -rf /var/lib/apt/lists/*

### mailing support
RUN apt-get update && apt-get install -y ssmtp heirloom-mailx mysql-client \
	&& apt-get -y autoremove \
	&& rm -rf /var/lib/apt/lists/*

## to quickly build DEV version
#cd ~/Dev/xtbackup/
#tar --exclude='.git' -pczf ~/Dev/dockerfiles/xtbackup/xtbackup.tar.gz xtbackup
#ADD xtbackup.tar.gz /usr/src/

## install xtbackup
RUN if [ ! -d /usr/src/xtbackup ]; then \
    curl -o xtbackup.tar.gz -SL https://github.com/k2s/xtbackup/archive/v0.8.7.tar.gz \
	&& echo "bbad2de54867184e8d20866792296922 *xtbackup.tar.gz" | md5sum -c - \
	&& tar -xzf xtbackup.tar.gz -C /usr/src/ \
	&& mv /usr/src/xtbackup-0.8.7 /usr/src/xtbackup \
	&& rm xtbackup.tar.gz ; \
    fi ; \
    chmod +x "/usr/src/xtbackup/xtbackup.sh" \
	&& ln -s /usr/src/xtbackup/xtbackup.sh /usr/bin/xtbackup

RUN curl -o aws.tar.gz -SL https://github.com/amazonwebservices/aws-sdk-for-php/archive/1.6.3.tar.gz \
	&& echo "6c6b4d4b3d181f8ef29ee7772836d9e1 *aws.tar.gz" | md5sum -c - \
	&& tar -xzf aws.tar.gz -C /usr/src/ \
	&& mv /usr/src/aws-sdk-for-php-1.6.3/* /usr/src/xtbackup/lib/AWSSDKforPHP/ \
	&& rm aws.tar.gz

ENV XTBACKUP_OPENDIR ""
CMD [ "xtbackup", "-h" ]

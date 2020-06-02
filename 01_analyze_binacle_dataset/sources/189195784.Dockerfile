#BUILD_PUSH=hub,quay
FROM mysql:5.6 

RUN apt-get update && apt-get install -y php5-cli php5-mysql curl \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

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

RUN apt-get update && apt-get install -y php5-sqlite \
     && apt-get -y autoremove \
          && rm -rf /var/lib/apt/lists/*


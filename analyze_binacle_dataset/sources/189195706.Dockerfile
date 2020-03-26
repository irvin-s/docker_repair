#BUILD_PUSH=hub,quay
FROM bigm/base-deb-tools

# VCS
RUN /xt/tools/_apt_install git-flow subversion

# interact with S3 bucket
RUN /xt/tools/_apt_install python-magic s3cmd

# Amazon CLI
RUN /xt/tools/_apt_install python-pip jq
RUN pip install awscli

# nodej stuff
RUN /xt/tools/_apt_install nodejs nodejs-legacy npm
RUN npm install --global gulp bower yo

# php stuff
RUN /xt/tools/_apt_install php5-cli php-pear pear-channels php5-dev build-essential php5-curl
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# ruby stuff
RUN /xt/tools/_apt_install ruby-full rubygems-integration
RUN gem install sass compass zen-grids sassy-buttons sass-globbing

# for better ssh tunnel creation
RUN /xt/tools/_apt_install autossh

#= oracle_jdk7
# install Oracle Java
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
    && echo oracle-java7-installer shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
    && /xt/tools/_ppa_install ppa:webupd8team/java ca-certificates oracle-java7-installer \
    && rm -rf /var/cache/oracle-jdk7-installer
# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
#= .oracle_jdk7

#= liquibase
RUN /xt/tools/_apt_install mysql-client libmysql-java
ENV VERSION_LIQUIBASE 3.4.2
RUN /xt/tools/_download /tmp/liquibase.zip https://github.com/liquibase/liquibase/releases/download/liquibase-parent-${VERSION_LIQUIBASE}/liquibase-${VERSION_LIQUIBASE}-bin.zip \
    && unzip -q -d /opt/liquibase /tmp/liquibase.zip \
    && rm /tmp/liquibase.zip \
    && ln -s /usr/share/java/mysql-connector-java.jar /opt/liquibase/lib/mysql-connector-java.jar
#= .liquibase

# fix problems with composer cache
ENV COMPOSER_CACHE_DIR /dev/null

# final settings
ENV PATH $PATH:/xt/dev/bin
RUN echo "set-option -g default-shell /bin/zsh" > /root/.tmux.conf
RUN echo "export TERM=xterm-color" >> /root/.bashrc
WORKDIR /prj
CMD ["zsh"]

# some more php modules
RUN /xt/tools/_apt_install php5-apcu php5-mcrypt php5-gd php5-mysql \
  && php5enmod mcrypt
RUN /xt/tools/_apt_install translate-toolkit
RUN pear install SQL_Parser-0.6.0

RUN /xt/tools/_apt_install libyaml-dev \
  && yes "" | pecl install yaml \
  && echo "extension=yaml.so" > /etc/php5/mods-available/yaml.ini \
  && php5enmod yaml

# fix sass-globbing version
RUN gem install sass-globbing -v 1.1.0 \
  && gem uninstall sass-globbing -v 1.1.1

# rsync client needed for deployment
RUN /xt/tools/_apt_install rsync

ADD ci.sh /xt/ci.sh
ENV DOWNLOAD_URL ""
ENV DOWNLOAD_RSYNC ""
ENV UPLOAD_RSYNC ""

### email management tools
RUN /xt/tools/_apt_install fetchmail procmail \
  && PERL_MM_USE_DEFAULT=1 cpan -if Mail::DeliveryStatus::BounceParser

### enable sending emails from inside of this docker
RUN /xt/tools/_enable_ssmtp \
    && /xt/tools/_apt_install heirloom-mailx

### the new mongodb extension
RUN	/xt/tools/_apt_install libcurl4-openssl-dev libpcre3-dev \
    && yes "" | pecl install mongodb \
	&& echo "extension=mongodb.so" > /etc/php5/mods-available/mongo.ini \
	&& php5enmod mongo

### fix https://github.com/npm/npm/issues/12196
#RUN npm install -g npm@latest-2

### library upgrade checking tools
RUN npm install -g bower-update npm-check-updates salita 

### latest composer 
RUN composer self-update

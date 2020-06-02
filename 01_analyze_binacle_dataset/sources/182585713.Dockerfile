FROM debian:stable
MAINTAINER Martin Høgh<mh@mapcentia.com>

RUN export DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i "s#deb http://deb.debian.org/debian stable main#deb http://deb.debian.org/debian stable main contrib non-free#g" /etc/apt/sources.list &&\
    sed -i "s#deb http://security.debian.org/debian-security stable/updates main#deb http://security.debian.org/debian-security stable/updates main contrib non-free#g" /etc/apt/sources.list &&\
    sed -i "s#deb http://deb.debian.org/debian stable-updates main#deb http://deb.debian.org/debian stable-updates main contrib non-free#g" /etc/apt/sources.list

# Install packages
RUN apt-get -y update  --fix-missing
RUN apt-get -y install cron vim wget g++ build-essential git unzip rng-tools apache2-utils postgresql-client supervisor netcat \
    apache2 php-fpm php-pgsql php-curl php-sqlite3 php-mbstring php-gd php-cli php-mbstring php-pear php-dev php7.0-zip \
    cmake libgdal-dev librsvg2-dev libpng++-dev libjpeg-dev libfreetype6-dev libproj-dev libfribidi-dev libharfbuzz-dev libcairo2-dev \
    libgeos++-dev libpython-all-dev curl libapache2-mod-fcgid libfcgi-dev xvfb nodejs osm2pgsql postgis swig sudo \
    apt-transport-https ca-certificates default-jre default-jdk \
    libprotobuf-c-dev libprotobuf-dev libprotobuf-c1 libprotobuf10 protobuf-compiler protobuf-c-compiler libtool


# Get libs for MS Access support in GDAL
RUN cd ~ &&\
    wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mdb-sqlite/mdb-sqlite-1.0.2.tar.bz2 &&\
    tar -vxjf mdb-sqlite-1.0.2.tar.bz2 &&\
    cp mdb-sqlite-1.0.2/lib/jackcess-1.1.14.jar /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/ext/ &&\
    cp mdb-sqlite-1.0.2/lib/commons-logging-1.1.1.jar /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/ext/ &&\
    cp mdb-sqlite-1.0.2/lib/commons-lang-2.4.jar /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/ext/

# Add SQLite3 module to php.ini
RUN echo "extension=sqlite3.so" >> /etc/php/7.0/fpm/php.ini

# Install rar
RUN pecl install rar &&\
	echo "extension=rar.so" >> /etc/php/7.0/fpm/php.ini

# Make php-fpm run in the foreground
RUN sed 's/;daemonize = yes/daemonize = no/' -i /etc/php/7.0/fpm/php-fpm.conf

# Install Node.js, Grunt and Forever
RUN curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh &&\
    bash nodesource_setup.sh &&\
    apt-get install nodejs

RUN npm install -g grunt-cli

ENV LD_LIBRARY_PATH /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server

# Enable Apache2 modules
RUN a2enmod rewrite headers expires include actions alias cgid fcgid ssl proxy proxy_http proxy_ajp proxy_balancer proxy_connect proxy_html xml2enc proxy_wstunnel proxy_fcgi http2
RUN a2enconf serve-cgi-bin

# Start fpm, so dirs are created
RUN service php7.0-fpm start

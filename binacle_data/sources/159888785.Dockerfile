# Docker: Google App Engine

FROM robloach/forge-mysql
MAINTAINER Rob Loach <robloach@gmail.com>


# PHP 5.4

RUN apt-get update -y
RUN apt-get install gcc libmysqlclient-dev libxml2-dev make -y
RUN wget --trust-server-names http://us2.php.net/get/php-5.4.25.tar.bz2/from/us1.php.net/mirror
RUN tar -xvf php-5.4.25.tar.bz2
WORKDIR php-5.4.25
RUN ./configure --prefix=$PWD/installdir --enable-bcmath --with-mysql
RUN make install


# Google App Engine

# Download Google App Engine SDK
RUN wget -O /appengine.zip https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.6.zip

# Extract it
RUN apt-get install unzip -y
RUN unzip /appengine.zip -d /appengine

# Python and PHP CGI are required to run Google App Engine SDK
RUN apt-get install python2.7 python-pil -y

# Set up the Supervisor configuration
ADD configs/appengine/supervisor.conf /etc/supervisor/conf.d/appengine.conf

# Add the Google App Engine nag configuration
ADD configs/appengine/appcfg_nag /root/.appcfg_nag


# Start

WORKDIR "/app"
VOLUME ["/app"]
EXPOSE 22 8000 8080
CMD ["supervisord", "-n"]

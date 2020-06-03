FROM ubuntu:16.04

MAINTAINER Fabien Thalgott <fabien.thalgott@gmail.com>

RUN apt-get update && apt-get install -y \
    apache2 \
    curl \
    git \
	libapache2-mod-php7.0 \
    php7.0 \
	php7.0-zip \
    python \
    python-pip \
	graphviz \
	python-pydot \
	python-pydot-ng

WORKDIR /root/
RUN git clone https://github.com/project-cx/dot-tm.git
RUN echo '#!/bin/bash' >> run.sh
RUN echo '/usr/sbin/apache2ctl start' >> run.sh
RUN echo 'while [ true ]' >> run.sh
RUN echo 'do' >> run.sh
RUN echo '  rm /var/www/html/graphs/*' >> run.sh
RUN echo '  sleep 500' >> run.sh
RUN echo 'done' >> run.sh

RUN chmod +x run.sh 

RUN mv dot-tm/* /var/www/html/ 

WORKDIR /var/www/html/
RUN mkdir /var/www/html/graphs
RUN chmod 777 /var/www/html/graphs
RUN echo '<meta http-equiv="refresh" content="0; url=./dot-tm.html" />' > index.html
ENTRYPOINT ["/root/run.sh", "-D", "FOREGROUND"]

EXPOSE 80/tcp

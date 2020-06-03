FROM python:2.7
MAINTAINER Ahmed <ahmedaabdulwahed@gmail.com>

ADD . /code
WORKDIR /code/
RUN pip install -r requirements.txt

# Install common packages
RUN apt-get update
RUN apt-get dist-upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python-software-properties unzip apache2 libapache2-mod-python \
software-properties-common apt-utils python-mysqldb python-sqlite python-yaml python-dev python-pip python-ipaddr \
python-mechanize python-paramiko python-dnspython supervisor

# Install Java 6 Oracle.
RUN ./jdk-6u45-linux-x64.bin
RUN mkdir -p /usr/lib/jvm
RUN mv jdk1.6.0_45 /usr/lib/jvm/java-6-oracle
RUN update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/java-6-oracle/bin/java" 1
RUN update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/java-6-oracle/bin/javac" 1
RUN update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/java-6-oracle/bin/javaws" 1 
RUN chmod a+x /usr/bin/java
RUN chmod a+x /usr/bin/javac
RUN chmod a+x /usr/bin/javaws
RUN chown -R root:root /usr/lib/jvm/java-6-oracle/
ENV JAVA_HOME /usr/lib/jvm/java-6-oracle

# Extract tavaxy files
RUN unzip tavaxy-dev.zip
RUN mv tavaxy-dev/  /var/www/tavaxy
RUN chmod 777 -R /var/www/tavaxy

# Add Ubuntu User
RUN useradd -ms /bin/bash ubuntu
RUN apt-get -y install sudo 
RUN echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# configure Environment Variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV TAVAXYHOME /var/www/tavaxy

# Grant Permissions
WORKDIR ${TAVAXYHOME}
RUN chown -R www-data webui
RUN chgrp -R ubuntu bin
RUN chmod -R g+rx bin
RUN chown -R ubuntu engines
RUN chmod -R o+rwx engines
#RUN chmod -R a-rwx .
#RUN chomd -R g+r .

# configure apache2 server
WORKDIR /code/
RUN mv default.conf /etc/apache2/sites-enabled/000-default.conf
#RUN cp /etc/apache2/sites-enabled/default /etc/apache2/sites-available/000-default.conf

# Config in /srv/apache.conf
#RUN rm -f /etc/apache2/sites-enabled/* && \
#    ln -s /srv/apache.conf /etc/apache2/sites-enabled/default

# Add supervisor config
ADD ./apache.foreground.sh /etc/apache2/foreground.sh
RUN chmod +x /etc/apache2/foreground.sh
ADD ./supervisord.apache.conf /etc/supervisor/conf.d/apache.conf

EXPOSE 80
# start apache2
CMD /usr/bin/supervisord -n


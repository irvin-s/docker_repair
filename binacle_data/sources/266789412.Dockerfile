FROM registry.access.redhat.com/rhel7
MAINTAINER Student <student@example.com>

# ADD set up scripts
ADD scripts /scripts
RUN chmod 755 /scripts/*

# Disable all but the necessary repo(s)
RUN yum-config-manager --disable \* &> /dev/null
RUN yum-config-manager --enable rhel-7-server-rpms

# Common Deps
RUN yum -y install openssl
RUN yum -y install psmisc

# Deps for wordpress
RUN yum -y install httpd
RUN yum -y install php
RUN yum -y install php-mysql
RUN yum -y install php-gd
RUN yum -y install tar

# Deps for mariadb
RUN yum -y install mariadb-server
RUN yum -y install net-tools
RUN yum -y install hostname

# Add in wordpress sources 
COPY latest.tar.gz /latest.tar.gz
RUN tar xvzf /latest.tar.gz -C /var/www/html --strip-components=1 
RUN rm /latest.tar.gz
RUN chown -R apache:apache /var/www/

EXPOSE 80
CMD ["/bin/bash", "/scripts/start.sh"]

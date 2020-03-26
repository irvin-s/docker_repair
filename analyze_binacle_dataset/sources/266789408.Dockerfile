FROM registry.access.redhat.com/rhel7
MAINTAINER Student <student@example.com>

RUN yum -y install httpd --disablerepo "*" --enablerepo rhel-7-server-rpms
RUN echo "Apache" >> /var/www/html/index.html
RUN echo 'PS1="[apache]#  "' > /etc/profile.d/ps1.sh

EXPOSE 80

# Simple startup script to avoid some issues observed with container restart 
ADD run-apache.sh /run-apache.sh
RUN chmod -v +x /run-apache.sh

CMD [ "/run-apache.sh" ]

FROM ubuntu:14.04
MAINTAINER oliver@cloudsurge.co.uk

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -fy software-properties-common

#Add repository that contains the landscape server
RUN add-apt-repository ppa:landscape/15.01
RUN apt-get update
RUN apt-get -fy dist-upgrade 

RUN apt-cache search landscape
RUN apt-get -fy install supervisor landscape-server apache2-mpm-worker

RUN for module in rewrite proxy_http ssl headers expires; do sudo a2enmod $module; done
RUN a2dissite 000-default

COPY assets/landscape-service.conf /etc/landscape/service.conf
COPY assets/apache-landscape.conf /etc/apache2/sites-available/landscape.conf

COPY assets/certs/landscape_server.key /etc/ssl/private/
COPY assets/certs/landscape_server.pem /etc/ssl/certs/
COPY assets/certs/landscape_server_ca.crt /etc/ssl/certs/

RUN a2ensite landscape.conf

COPY assets/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["app:start"]

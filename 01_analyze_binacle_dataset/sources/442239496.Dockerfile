# MySQL Server with Apache and phpmyadmin
#
# VERSION               0.0.1

FROM     base
MAINTAINER Jonas Colmsjö "jonas@gizur.com"


RUN apt-get update
RUN apt-get install -y curl git wzdftpd

EXPOSE 20 21
CMD ["/usr/sbin/wzdftpd","-s"]

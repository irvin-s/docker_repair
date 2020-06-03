FROM busybox:latest

MAINTAINER Zakariae Filali <filali.zakariae@gmail.com>

ADD . /var/www/app

CMD ["/bin/true"]
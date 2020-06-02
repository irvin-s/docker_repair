FROM fedora:26
MAINTAINER Alan Franzoni username@franzoni.eu
ADD files/etc/yum.conf /etc/
ADD files/tmp /tmp
RUN rpm --import  /tmp/*.txt
RUN touch /var/lib/rpm/* ; dnf -y upgrade
RUN touch /var/lib/rpm/* ; dnf -y install @"Minimal Install" @buildsys-build yum-utils rpm-sign gnupg expect
RUN touch /var/lib/rpm/* ; dnf -y install spawn
RUN mv /tmp/rpm-sign.exp /usr/local/bin/rpm-sign.exp

FROM fedora:27
MAINTAINER Alan Franzoni username@franzoni.eu
ADD files/etc/yum.conf /etc/
ADD files/tmp /tmp
RUN touch /var/lib/rpm/* ; rpm --import  /tmp/*.txt ; dnf -y upgrade ; dnf -y install @"Minimal Install" @buildsys-build yum-utils rpm-sign gnupg ; dnf clean all

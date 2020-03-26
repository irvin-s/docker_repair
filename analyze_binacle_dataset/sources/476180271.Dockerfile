# Google Chrome
# @author Lorenzo Fontana <fontanalorenzo@me.com>
FROM centos:centos7

MAINTAINER Lorenzo Fontana, fontanalorenzo@me.com

RUN yum install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -y
RUN dbus-uuidgen > /var/lib/dbus/machine-id

VOLUME ["/google-chrome-data"]
ENTRYPOINT ["google-chrome"]
CMD ["--user-data-dir=/google-chrome-data", "--no-sandbox"]

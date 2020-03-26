#
#   Author: Rohith (gambol99@gmail.com)
#   Date: 2014-12-30 16:23:59 +0000 (Tue, 30 Dec 2014)
#
#  vim:ts=2:sw=2:et
#
FROM progrium/busybox
MAINTAINER <gambol99@gmail.com>

ADD startup.sh ./startup.sh
RUN opkg-install curl
RUN curl -ksL https://drone.io/github.com/gambol99/config-fs/files/config-fs.gz > /bin/config-fs.gz
RUN md5sum /bin/config-fs.gz
RUN gunzip /bin/config-fs.gz
RUN chmod +x /startup.sh; chmod +x /bin/config-fs

ENTRYPOINT [ "/startup.sh" ]

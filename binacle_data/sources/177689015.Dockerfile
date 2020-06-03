#
#   Author: Rohith (gambol99@gmail.com)
#   Date: 2014-12-23 14:44:32 +0000 (Tue, 23 Dec 2014)
#
#  vim:ts=2:sw=2:et
#
FROM busybox
MAINTAINER <gambol99@gmail.com>

ADD ./stage/config-fs /bin/config-fs
ADD ./stage/startup.sh ./startup.sh
RUN chmod +x /startup.sh; chmod +x /bin/config-fs

VOLUME [ "/config" ]
ENTRYPOINT [ "/startup.sh" ]

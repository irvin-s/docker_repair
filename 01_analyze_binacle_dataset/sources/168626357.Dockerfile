#
#   Author: Rohith (gambol99@gmail.com)
#   Date: 2014-10-21 10:51:37 +0100 (Tue, 21 Oct 2014)
#
#  vim:ts=2:sw=2:et
#
FROM base
MAINTAINER <gambol99@gmail.com>
RUN apt-get install -y apache2 && \
  mkdir /etc/apache2/




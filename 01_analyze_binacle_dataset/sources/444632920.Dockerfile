FROM ubuntu
MAINTAINER AJ Christensen <aj@junglist.io>
ADD http://download01.thoughtworks.com/go/13.2/ga/go-server-13.2.0-17155.deb /tmp/go-server.deb
ADD policy-rc.d /usr/sbin/policy-rc.d
ADD dependencies.sh /
RUN /dependencies.sh
ADD go-server /etc/default/go-server
ADD start.sh /start.sh
CMD /start.sh
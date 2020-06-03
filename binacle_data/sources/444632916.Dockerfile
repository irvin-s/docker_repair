FROM ubuntu
MAINTAINER AJ Christensen <aj@junglist.io>
ADD http://download01.thoughtworks.com/go/13.2/ga/go-agent-13.2.0-17155.deb /tmp/go-agent.deb
ADD dependencies.sh /
RUN /dependencies.sh
ADD go-agent /etc/default/go-agent
ADD start.sh /start.sh
CMD /start.sh
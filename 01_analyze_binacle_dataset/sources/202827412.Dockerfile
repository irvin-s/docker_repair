FROM websphere-liberty:webProfile7

MAINTAINER Erin Schnabel @ebullientworks

ADD ./target/wlp/usr/servers/gojava-room /opt/ibm/wlp/usr/servers/defaultServer/

CMD ["/opt/ibm/wlp/bin/server", "run"]

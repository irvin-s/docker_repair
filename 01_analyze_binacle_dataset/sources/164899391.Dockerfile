FROM busybox
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

RUN mkdir /webapps
ADD status.war /webapps/status.war

VOLUME ["/webapps"]

CMD true 

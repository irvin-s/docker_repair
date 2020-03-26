FROM busybox
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

RUN mkdir /webapps
ADD hello.war /webapps/hello.war

VOLUME ["/webapps"]

CMD /bin/sh

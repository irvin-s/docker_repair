# BUILDING
# docker build -t stuckless/sagetv-server-java8:latest .

FROM stuckless/sagetv-server-java8:latest

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

RUN mkdir /opt/phoenix-renamer/
ADD cmd-rename-failed /opt/phoenix-renamer/
ADD cmd-rename-ok /opt/phoenix-renamer/
ADD phoenix-renamer /opt/phoenix-renamer/
ADD install-phoenix-renamer.sh /opt/phoenix-renamer/

CMD /opt/phoenix-renamer/install-phoenix-renamer.sh && sleep infinity

FROM open-liberty:kernel-java8-openj9

RUN cp /opt/ol/wlp/templates/servers/microProfile2/server.xml /config/server.xml

FROM open-liberty:19.0.0.3-kernel-java8-ibm

RUN cp /opt/ol/wlp/templates/servers/microProfile2/server.xml /config/server.xml

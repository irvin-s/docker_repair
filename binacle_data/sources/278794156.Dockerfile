FROM open-liberty:kernel-java12

RUN cp /opt/ol/wlp/templates/servers/springBoot2/server.xml /config/server.xml

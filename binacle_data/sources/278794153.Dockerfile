FROM open-liberty:kernel-java8-ibmsfj

RUN cp /opt/ol/wlp/templates/servers/springBoot1/server.xml /config/server.xml

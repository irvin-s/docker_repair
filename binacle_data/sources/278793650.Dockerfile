FROM open-liberty:kernel-ubi-min

RUN cp /opt/ol/wlp/templates/servers/microProfile1/server.xml /config/server.xml

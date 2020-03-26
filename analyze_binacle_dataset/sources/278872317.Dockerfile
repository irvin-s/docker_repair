FROM openliberty/open-liberty:kernel
COPY target/liberty/wlp/usr/servers/userServer /config
COPY target/liberty/wlp/usr/shared /opt/ol/wlp/usr/shared

FROM openliberty/open-liberty:kernel
COPY target/liberty/wlp/usr/servers/groupServer /config
COPY target/liberty/wlp/usr/shared /opt/ol/wlp/usr/shared
RUN sed -i -e 's/httpEndpoint/httpEndpoint host="*"/g' /config/server.xml

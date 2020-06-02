FROM openliberty/open-liberty:kernel
COPY target/wlp/usr/servers/OccasionsServer /config
COPY target/wlp/usr/shared /opt/ol/wlp/usr/shared
RUN sed -i -e 's/httpEndpoint/httpEndpoint host="*"/g' /config/server.xml
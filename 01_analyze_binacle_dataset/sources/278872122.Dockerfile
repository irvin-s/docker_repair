FROM openliberty/open-liberty:kernel
COPY target/liberty/wlp/usr/servers/UIServer /config
RUN sed -i -e 's/httpEndpoint/httpEndpoint host="*"/g' /config/server.xml

FROM openliberty/open-liberty:kernel
COPY target/liberty/wlp/usr/servers/authServer /config

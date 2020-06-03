FROM logstash:latest

# Download GeoIP Data
RUN mkdir -p /usr/share/GeoIP/ && \
   curl "http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz" >> /usr/share/GeoIP/GeoLiteCity.dat.gz && \
   gunzip /usr/share/GeoIP/GeoLiteCity.dat.gz

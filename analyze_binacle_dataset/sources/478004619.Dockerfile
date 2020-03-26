FROM java:8-jre

WORKDIR /srv

#RUN wget -e use_proxy=yes -e http_proxy=10.129.250.100:8080 http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz
RUN wget http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz
RUN gunzip GeoLite2-City.mmdb.gz


COPY build/install/lumbermill-simple-samples lumbermill-simple-samples
ADD  src/main/groovy /srv

ENTRYPOINT ["/srv/lumbermill-simple-samples/bin/lumbermill-simple-samples"]

CMD ["docker-welcome.groovy"]

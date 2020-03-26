FROM python:3-alpine

RUN \
  apk add --update bash curl ca-certificates geoip && \
  pip install awscli==1.11.41 && \
  rm -rf /tmp/* /var/cache/apk/*

RUN \
  wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz && \
  gunzip GeoLiteCity.dat.gz && \
  mv GeoLiteCity.dat /usr/share/GeoIP/

ADD . /opt/app/

RUN chmod +x /opt/app/start.sh

WORKDIR /opt/app

ENTRYPOINT ["/opt/app/start.sh"]

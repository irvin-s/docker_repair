FROM influxdb:1.7.4-alpine

ENV INFLUXDB_HTTP_HTTPS_ENABLED=true INFLUXDB_HTTP_HTTPS_CERTIFICATE=/etc/ssl/certificate.pem INFLUXDB_HTTP_HTTPS_PRIVATE_KEY=/etc/ssl/certificate.key INFLUXDB_ADMIN_ENABLED=true INFLUXDB_ADMIN_USER=alameda INFLUXDB_ADMIN_PASSWORD=alameda INFLUXDB_USER=alameda INFLUXDB_USER_PASSWORD=alameda

RUN apk add --no-cache curl vim openssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $INFLUXDB_HTTP_HTTPS_PRIVATE_KEY -out $INFLUXDB_HTTP_HTTPS_CERTIFICATE \
      -subj "/C=  /ST= /L= /O= /OU= /CN= /emailAddress= "

EXPOSE 8086/TCP

COPY ["init/", "/docker-entrypoint-initdb.d"]
